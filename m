From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Two sound cards, only sound out of one
Date: Fri, 29 Aug 2003 12:54:39 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030829125439.34e60138.erikd-alsa@mega-nerd.com>
References: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
	<20030824095120.49055.qmail@web40613.mail.yahoo.com>
	<20030824203749.27d69196.erikd-alsa@mega-nerd.com>
	<1061914407.2317.9.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1061914407.2317.9.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Aug 2003 09:13:27 -0700
Mark Knecht <markknecht@comcast.net> wrote:

> Erik,
>    As I've watched this thread 

Thanks :-).

> I wonder how sure you are that amixer
> settings for the second card are actually going to the second card? Are
> you able to set different volume and mute settings for the two cards and
> show that they are truly different values?

I'm running two instances of alsamixergui using:

    alsamixergui -c 0 &
    alsamixergui -c 1 &

The resulting windows are slightly different (due I believe to the different
manufacturers supplying slightly different features) and the controls act
completely independantly. 

If the alsamixergui instances were talking to the same card I would expect
the windows to be the same, and movement of the controls on one window to
be reflcected in the other (I have tested this).

>    Also, I've had real problems recently with aplay, 

Well if this is a problem with aply, I hope that this might shake it out.
I really don't have very much free time at the moment and I would prefer
not to add more variables to the situation because that is only likely
to confuse the issue.

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"Microsoft treats security vulnerabilities as public relations problems." 
 -- Bruce Schneier


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
