From: Peter L Jones <peter@drealm.org.uk>
Subject: Re: snd_ prefix for module options
Date: Thu, 10 Oct 2002 19:49:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210101949.04523@advent.drealm.org.uk>
References: <s5hfzvh2fid.wl@alsa2.suse.de> <200210091937.05652@advent.drealm.org.uk> <87u1juxoit.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87u1juxoit.fsf@sulphur.joq.us>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jack O'Quin <joq@io.com>
Cc: Takashi Iwai <tiwai@suse.de>, Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 10 Oct 2002 17:11, Jack O'Quin wrote:
[snip]
> I don't mean to single out Peter for this one statement.  But, I am
> totally frustrated with the attitude that ALSA is only for power users
> and that it's OK to introduce spurious incompatibilities on a whim.
>
> The excuse that 0.9 is not a "release" is wearing thin these days.
> Since 0.5, which *is* a release, is "no longer supported", what are
> ordinary users expected to run?  OSS?
>
> ALSA is part of the 2.5 kernel now.  It is mainstream Linux software,
> good technology, needed by many users.  Isn't it about time to start
> thinking and acting that way?

Hi Jack - don't mind singling me out!

In principle, I'd agree entirely with you but

(a) ALSA 0.9.0-rc3 is not ALSA 0.9.0.  Once it is, it will really be too late 
until ALSA 1.0.0

(b) Kernel 2.5.x is really a poor argument :-).  Again, if ALSA has module 
parms begining snd_ in 2.6.x, then it's stuck with it for a long time.

(I'm hoping (a) == (b) myself.)

I agree, any breakage is bad breakage but waiting will make it worse and I 
think it should be done (should have been done earlier but it should still be 
done).

-- Peter


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
