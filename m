From: patrick reardon <swpatrick@earthlink.net>
Subject: Re: possible problems with rc6 aplay
Date: Tue, 17 Dec 2002 11:08:40 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFF5A18.A861D1BA@earthlink.net>
References: <200212161844.18o7IP2Gs3NZFjV0@sparrow.mail.pas.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >yes, thnx, it's much clearer now.  my converter is external with no
> >rate switches and from the manual i just discovered it always
> >operates at 48000 (Alesis AI-3).  i'm s till uncertain how to change
> >the card's configuration though.  "alsactl" doesn't seem to provide
> >an obvious way to do this (looking at the man page).  but my
> >asound.state file has [ ... ]
> 
> what do you want to change it to?
> 
> --p

thanks to all the posts about my problem, i inferred that setting the "Preferred Sync
Source" of the hammerfall to Master would be one way to solve the problem, and possibly
solve some others too, like third party WAV files at 22050 that play back way too fast
regardless of the --rate=# option given to "aplay".  (in my setup, play back output runs
through the converter to an analog mixer and then on to the speakers.)  

i just looked again at the asound.state file with a fresh pair of eyes, and apparently the
only allowable values for Preferred Sync Source are IEC958, ADAT1, and ADAT2.  Sync Mode
seems to be the only control that has Master as an allowable value,  (this based on my
guess that lines like "comment.item.# <string>" list the allowable values for the
parameter.)  

on the other hand, i could leave ADAT1 as the preferred sync source and give "arecord" the
option -f dat to make 48000 WAV files, then resample to 44100 when i want to burn a CD. 
maybe this approach wouldn't confuse Alsa into writing incorrect headers, but i don't know
if it would sacrifice audio quality on the resulting CD (as opposed to just recording
everything at 44100).  

patrick


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
