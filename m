From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - utils 0001174]: Speaker Test fails with error message(s)
 from alsa lib.  "problem for start_threshold"
Date: Wed, 22 Jun 2005 18:22:17 +0800
Message-ID: <42B93BD9.4060806@netvigator.com>
References: <315013d76908703237d6b3c53ef285d4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <315013d76908703237d6b3c53ef285d4@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I notice that there are female voice wav files in samples subdirectory.

ls speaker-test/samples
Front_Center.wav  Makefile     Noise.wav        Rear_Right.wav 
Side_Right.wav
Front_Left.wav    Makefile.am  Rear_Center.wav  sample_map.csv
Front_Right.wav   Makefile.in  Rear_Left.wav    Side_Left.wav


Is there an option to use female voice instead of pink noise, sine wave ?

speaker-test --help

speaker-test 0.0.8

Usage: speaker-test [OPTION]...

-t,--test       1=use pink noise, 2=use sine wave


bugtrack@alsa-project.org wrote:
> A NOTE has been added to this issue.
> ======================================================================
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1174> 
> ======================================================================
> Reported By:                herby
> Assigned To:                
> ======================================================================
> Project:                    ALSA - utils
> Issue ID:                   1174
> Category:                   speakertest
> Reproducibility:            always
> Severity:                   major
> Priority:                   normal
> Status:                     new
> ======================================================================
> Date Submitted:             06-09-2005 00:42 CEST
> Last Modified:              06-22-2005 11:39 CEST
> ======================================================================
> Summary:                    Speaker Test fails with error message(s) from alsa
> lib.  "problem for start_threshold"
> Description: 
> Running speaker test gets me:
> 
> speaker-test 0.0.8
> 
> Playback device is plughw:0,0
> Stream parameters are 48000Hz, S16_LE, 1 channels
> Using 16 octaves of pink noise
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 16 to 32768
> Period size range from 8 to 16384
> Periods = 4
> Buffer time size 2525
> To choose buffer_size = 15052
> To choose period_size = 3763
> was set period_size = 3764
> was set buffer_size = 15052
> ALSA lib pcm.c:824:(snd_pcm_sw_params) snd_pcm_sw_params:
> params->avail_min problem for start_threshold
> Unable to set sw params for playback: Invalid argument
> Setting of swparams failed: Invalid argument
> <<<
> ======================================================================
> 
> ----------------------------------------------------------------------
>  herby - 06-22-05 10:19 
> ----------------------------------------------------------------------
> I've seen recent notes on the frequency range for speaker test (nice to
> have a wide range of things).  Has anyone tried the latest version(s) to
> see if this bug pops its head up.  I've got other programs that appear to
> exhibit this (or a similar) error, but I feel that a standard program is a
> better example.  If you need more information, PLEASE let me know!
> 
> ----------------------------------------------------------------------
>  tiwai - 06-22-05 11:39 
> ----------------------------------------------------------------------
> The bug acked.  Will check what's going on there...
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
