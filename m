From: Tim Hollingsworth <tim@hollingsworth.com.au>
Subject: Re: period size
Date: Fri, 2 Apr 2004 20:30:25 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8436B8CE-84A1-11D8-B350-000A95AB8A40@hollingsworth.com.au>
References: <Pine.HPX.4.33n.0403301505490.25443-100000@studcom.urz.uni-halle.de> <EB5AA0AA-8258-11D8-88CD-000A95AB8A40@hollingsworth.com.au> <Pine.LNX.4.58.0403301729380.1835@pnote.perex-int.cz> <A521B1A8-838A-11D8-89F0-000A95AB8A40@hollingsworth.com.au> <Pine.LNX.4.58.0404011051250.1843@pnote.perex-int.cz>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0404011051250.1843@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for your help so far Jaroslav.

I have taken another look at my project and now it's behaving 
differently!  It still won't go down to a period size of 128.

I have downloaded the example sine wave generator.  It works with the 
default settings, which give a period size of 4410.  If I change the 
period time using the command line, it will successfully go down to 
441/10000us.  Any further and I get this error:

ALSA lib pcm.c:824:(snd_pcm_sw_params) snd_pcm_sw_params: 
params->avail_min problem for start_threshold
Unable to set sw params for playback: Invalid argument
Setting of swparams failed: Invalid argument


On 01/04/2004, at 4:52 PM, Jaroslav Kysela wrote:

> On Thu, 1 Apr 2004, Tim Hollingsworth wrote:
>
>>> You can read/write any size.
>>
>> well I can't write at 128.  the question is, do I need to buffer the
>> periods myself and sequence them into larger periods or will alsa do
>> this for me?
>
> The you have wrong sw_params settings. Check xfer_align.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
