From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-utils] [PATCH] Add support for no-rewind
 flag in aplay utility
Date: Wed, 31 Jan 2018 01:14:04 +0100
Message-ID: <68140ddd-1ee9-ba8b-68f9-6a55404b0343@linux.intel.com>
References: <1517304885-16750-1-git-send-email-sriramx.periyasamy@intel.com>
 <ae19083c-15f9-e65e-faa5-d75809885b07@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 38348267503
 for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2018 01:14:04 +0100 (CET)
In-Reply-To: <ae19083c-15f9-e65e-faa5-d75809885b07@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Patches Audio <patches.audio@intel.com>, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

On 1/30/18 11:40 AM, Takashi Sakamoto wrote:
> Hi,
> 
> On Jan 30 2018 18:34, Sriram Periyasamy wrote:
>> From: Ramesh Babu <ramesh.babu@intel.com>
>>
>> The "no-rewind" flag is introduced in alsa.
>> Application can use this flag to assure kernel driver
>> that rewind won't be exercised. Driver could use this
>> flag to alter it's buffering scheme to optimize power
>> and performance.
>>
>> Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
>> Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
>> ---
>>   aplay/aplay.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> Current implementation of 'aplay' doesn't perform rewinding/forwarding,
> thus an additional of this option is surplus.

It helps tell the driver that rewinds won't be used and indirectly that 
the appl_ptr updates are passed to the hardware.
Removing the option or making the functionality unconditional removes 
the freedom to test with or without this option.

> 
>> diff --git a/aplay/aplay.c b/aplay/aplay.c
>> index 6b740c281f8e..b50602a59024 100644
>> --- a/aplay/aplay.c
>> +++ b/aplay/aplay.c
>> @@ -108,6 +108,7 @@ static snd_pcm_stream_t stream = SND_PCM_STREAM_PLAYBACK;
>>   static int mmap_flag = 0;
>>   static int interleaved = 1;
>>   static int nonblock = 0;
>> +static int no_rewind = 0;
>>   static volatile sig_atomic_t in_aborting = 0;
>>   static u_char *audiobuf = NULL;
>>   static snd_pcm_uframes_t chunk_size = 0;
>> @@ -229,6 +230,7 @@ _("Usage: %s [OPTION]... [FILE]...\n"
>>   "-I, --separate-channels one file for each channel\n"
>>   "-i, --interactive       allow interactive operation from stdin\n"
>>   "-m, --chmap=ch1,ch2,..  Give the channel map to override or follow\n"
>> +"-w, --no-rewind         enables no rewind mode\n"
>>   "    --disable-resample  disable automatic rate resample\n"
>>   "    --disable-channels  disable automatic channel conversions\n"
>>   "    --disable-format    disable automatic format conversions\n"
>> @@ -470,7 +472,7 @@ int main(int argc, char *argv[])
>>   {
>>   	int duration_or_sample = 0;
>>   	int option_index;
>> -	static const char short_options[] = "hnlLD:qt:c:f:r:d:s:MNF:A:R:T:B:vV:IPCi"
>> +	static const char short_options[] = "hnlLD:qt:c:f:r:d:s:w:MNF:A:R:T:B:vV:IPCi"
>>   #ifdef CONFIG_SUPPORT_CHMAP
>>   		"m:"
>>   #endif
>> @@ -514,6 +516,7 @@ int main(int argc, char *argv[])
>>   		{"process-id-file", 1, 0, OPT_PROCESS_ID_FILE},
>>   		{"use-strftime", 0, 0, OPT_USE_STRFTIME},
>>   		{"interactive", 0, 0, 'i'},
>> +		{"no-rewind", 0, 0, 'w'},
>>   		{"dump-hw-params", 0, 0, OPT_DUMP_HWPARAMS},
>>   		{"fatal-errors", 0, 0, OPT_FATAL_ERRORS},
>>   #ifdef CONFIG_SUPPORT_CHMAP
>> @@ -753,6 +756,9 @@ int main(int argc, char *argv[])
>>   		case 'i':
>>   			interactive = 1;
>>   			break;
>> +		case 'w':
>> +			no_rewind = 1;
>> +			break;
>>   		case OPT_DISABLE_RESAMPLE:
>>   			open_mode |= SND_PCM_NO_AUTO_RESAMPLE;
>>   			break;
>> @@ -1396,6 +1402,12 @@ static void set_params(void)
>>   							     &buffer_frames);
>>   	}
>>   	assert(err >= 0);
>> +
>> +	if (no_rewind) {
>> +		err = snd_pcm_hw_params_set_no_rewind(handle, params, 1);
>> +		assert(err >= 0);
>> +	}
>> +
>>   	monotonic = snd_pcm_hw_params_is_monotonic(params);
>>   	can_pause = snd_pcm_hw_params_can_pause(params);
>>   	err = snd_pcm_hw_params(handle, params);
> 
> 
> Regards
> 
> Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
