From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Generating LFE-channel from Stereo Sound?
Date: Sun, 04 Jan 2004 14:36:17 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FF824E1.3010209@superbug.demon.co.uk>
References: <3FF7DCE2.4090104@aposso.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FF7DCE2.4090104@aposso.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thorsten Guenther <aposso@aposso.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thorsten Guenther wrote:
> Hi all!
> 
> 
> First i would like to thank you for your great work. Yesterday i watched 
> DVD and really enjoied doing so with 5.1 sound on my nforce2 Linux 
> system. :-)))
> After some hassle with the right settings for the DVD player software, 
> anything works great and there is only one feature i'm missing:
> 
> In the Windows sound driver there is an option to generate an LFE 
> channel from ordinary stero sound (e.g. MP3 playback). I searched the 
> net and this list for some time but did not find any hints for player- 
> or driver-options to do this. Am i missing something? Are there plans to 
> add such a feature? May i help in some way (i'm a developer, but the 
> java / server side type of) develop such a feature?
> 
> Tahnk's in advance!
> 
> Bye,
> Thorsten
> 
Converting stereo sound (2.0) to stereo with separate LFE (2.1) is best 
left to the media player, because high/low pass filters are CPU 
intensive, and would add too much delay in the audio out path, but can 
be done at the decoder stage, which is a stage in the media player 
before audio/video sync is attempted.

I don't know which media player you use, so I cannot comment further.

xine could support this by implementing a new audio_post_processing_plugin.
mplayer might already have this feature, look in the audio filters 
section of their manual.

Cheers
James


Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
