From: Andy Lo-A-Foe <andy@alsaplayer.org>
Subject: Re: 1.0.0 Requirements, Integration of sound deamon (JACK)
Date: Sun, 13 Oct 2002 13:23:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021013112302.GA21763@orbital.xs4all.nl>
References: <3DA6E82F.4070302@boosthardware.com> <20021013025239.17302.qmail@web40603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021013025239.17302.qmail@web40603.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: David Sankel <camio@yahoo.com>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 12, 2002 at 07:52:39PM -0700, David Sankel wrote:

> Yes, I have used jack.  I meant that it doesn't open
> the sound device when it is not being used by a host application.

Actually, I think it does. From the moment you start jackd it will open
the playback (and recording, depending on the options) devices. At
least, that's what I see with with jack 0.38.0, and possible newer
releases. 

Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
