From: Jaroslav Kysela <perex@suse.cz>
Subject: OpenAL & more
Date: Mon, 22 Dec 2003 09:55:17 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312220926550.8959@pnote.perex-int.cz>
References: <1072063439.1803.31.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1072063439.1803.31.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@mat.utfsm.cl>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 21 Dec 2003, Manuel Jander wrote:

> Hi,
> 
> I updated my ALSA- OpenAL interface proposal, taking into account some
> suggestions i have received, and some further investigations, specially
> on the side of OpenAL.
> 
> Take a look at:
> http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/OpenAL-ALSA.txt
> 
> AFAIK, the linux OpenAL port was not designed taken any hardware support
> into account. 
> 
> Things that go against my goals are:
> 
> - OpenAL only uses one single ALSA substream. There is no substream
> management (must be added).
> - OpenAL is not hardware mixing aware.
> - OpenAL ALSA structs must be changed to integrate hardware context
> data.
> 
> Things that are favorable:
> 
> - As far as i dug into OpenAL, it seems that all source buffer
> processing is done in one single place (_alMixSources). Replacing this
> call for hardware assisted sources seems feasible.
> 
> 
> The same as for the first iteration of this proposal, please take some
> minutes and give some comments/suggestions back. I need feedback.

Ok, regarding the last feedback:

1) try to make all controls non OpenAL specific
   - naming should be generic something like - "Ext3D ..."
   - the ranges and usage might be different per hardware
2) alsa-lib should provide a common entry point for all 3D APIs
   - I propose to have a special name for stream like "surround3d";
     note that stream in my eyes is one "voice"; we can use hw mixing
     or dmix in case when hw mixing is not available for final output
   - we need to add runtime controls for PCM streams to alsa-lib (see bottom),
     these controls will eventually map to hw controls or they won't be
     present in case when hardware acceleration does not exist

Proposal for runtime PCM controls:
==================================

int snd_pcm_control_list(snd_pcm_t * handle, snd_config_t ** list);
int snd_pcm_control_set(snd_pcm_t * handle, snd_config_t * value);
int snd_pcm_control_get(snd_pcm_t * handle, snd_config_t * value);

A short description: snd_pcm_control_list() returns a compound with list
of all keys (names of variables - controls - assigned to a PCM stream) and
other useful information (ranges, types, user representation etc.).  
snd_pcm_control_set() and snd_pcm_control_set() functions will set and get
the contents of value identified by given key.

Note that value might be also a compound so very complex data structures
might be passed through.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
