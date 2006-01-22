From: Daniel Mack <daniel@caiaq.de>
Subject: Re: some questions regarding multichannel devices
Date: Mon, 23 Jan 2006 00:33:54 +0100
Message-ID: <F3BA2D81-AA5D-4428-B2E9-82F8B52B8193@caiaq.de>
References: <43E897D5-9150-4960-8946-F6760B627283@caiaq.de> <1137970009.1354.2.camel@mindpipe>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1137970009.1354.2.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Lee,

Thanks for your reply.

On Jan 22, 2006, at 11:46 PM, Lee Revell wrote:
>> 	- the number of registered snd_pcm_t instances
>> 	- the number of substreams (4th and 5th param to snd_pcm_new()) and
>> 	- the value of channels_min, channels_max in my snd_pcm_hardware_t
>> 	  struct
>
> These should be set to reflect the capabilities of the hardware.
> alsa-lib takes care of translating various formats and channel  
> counts to
> something the hardware can understand.  You don't have to worry  
> about it
> in the driver.
>
> Substreams are only relevant if your device supports hardware mixing.

So let's say I have a device with 2 stereo inputs and 2 stereo outputs.
For this device, I would

	- register ONE instance of snd_pcm_t
	- register ONE input substream and ONE output substream
	- set channels_min = channels_max = 4 for both the input
	  and the output struct.

Is that right?

>> Also, does a driver need to take care about supporting as much data
>> formats
>> as possible (16/24/32 bits, LE/BE, ...)? Or is there any layer taking
>> care
>> about proper conversion? And if there is such a layer, does any tool
>> make use of that? At least, aplay refused to play a big-endian  
>> wave file thru
>> a device which only supports little-endian data transport according
>> to the
>> snd_pcm_hardware_t struct.
>
> See above - alsa-lib handles all these details for you, all you  
> need to
> consider when writing the driver is what the hardware supports.

Which tool would recommend for testing, though? As I said, aplay
definitely failed to do any conversion but simply refused to play
a file which was not coded in a way the hardware could understand
natively.

Also, I could not find a verbose tool for inspecting available ALSA
components found on a system, dumping all information which is available
theoretically. Is there such a thing?

Greets,
Daniel



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
