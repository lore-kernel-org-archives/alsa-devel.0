From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: MIDI velocity rewriting
Date: Wed, 08 Oct 2003 08:44:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065617099.1780.5.camel@localhost>
References: <20031008042134.GB3451@dbz.icequake.net>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031008042134.GB3451@dbz.icequake.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Ryan,

I encountered this same problem time ago on Windows using CakeWalk
Proaudio. But in this case, CakeWalk Proaudio provides a function to add
a offset to all MIDI notes on a given track. This isn't the best
solution since you loose dynamic range. Scaling would be better.
Having a solution like this in the library level, common for all
applications sounds reasonable to me. Many keyboards don't use the full
7 bit scale, so that could be considered as a "Hardware configuration
parameter".

I suggest: write a patch, and show it to Takashi and Jaroslav. They are
the boss around here :D 

Best Regards

Manuel

On Wed, 2003-10-08 at 00:21, Ryan Underwood wrote:
> Hi,
> 
> A problem that I have on some MIDI keyboards is that the velocity
> information sent by the keyboard is just too low.  Banging on the
> keyboard only results in a velocity of 90 for instance, instead of 127.
> I can fix this in MIDI that I have captured by scanning for note-on
> messages and adding either a fixed amount to them, or using a curve so
> that notes closer to the max are only increased a little, where ones
> that are very low get increased a lot.
> 
> The question is, does anyone know of any other way to make a MIDI louder
> besides setting the master volume of the performer to highest, and doing
> this rewriting of velocity information?  If not, I also had the idea
> that perhaps this would be a useful thing to do in the ALSA MIDI layer.
> For example, if the user specified to do so, the ALSA layer would
> automatically increase velocity in the desired way for each note-on
> message that comes from a given channel into the computer.
> 
> Of course there are probably things I haven't thought about, but
> comments would be appreciated.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
