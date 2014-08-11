From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver, a succesor to	firewire-speakers
Date: Tue, 12 Aug 2014 08:55:22 +0900
Message-ID: <53E957EA.3030601@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
	<53E795BD.1070100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <53E795BD.1070100@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Aug 11 2014 00:54, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> I have an issue for Griffin Firewave.
>>
>> This device can handle AV/C Stream Format Information command and
>> driver can get to know stream formations via the command.
>>
>> According to these responses, supported formations are:
>> Input Stream to device:
>> 	Rate	PCM	MIDI
>> 	32000	6	0
>> 	44100	6	0
>> 	48000	6	0
>> 	96000	6	0
>> 	32000	2	0
>> 	44100	2	0
>> 	48000	2	0
>>
>> But current 'firewire-speakers' has PCM constraints below:
>>  - 6ch at 32/44.1/48/96 kHz
>>  - 2ch at 48/96 kHz
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073562.html
>>
>> So this OXFW driver may lost a support for 2ch/96.0kHz for FireWave
>> and gain 2ch/32.0kHz and 2ch/44.1kHz.
>>
>> I don't know exactly the reason of these gaps.
> 
> The old driver configured nothing but the rate.  Is there any mechanism
> to set the stream format?

Yes. It's AV/C stream format information command.

The old driver uses AV/C plug signal format command. This command
basically get/set sampling rate.

But the stream format information command can be available to get/set
stream format and some models with OXFW, especially FireWave, uses this
command.

But in this series of patches, I don't use this command. I expected the
models to change stream format according to parameters in AMDTP packets
such like the value of dbs field.


Regards

Takashi Sakamoto
(In summer vacation)
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
