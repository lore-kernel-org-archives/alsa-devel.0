From: AthlonRob <athlonrob@data.4t3.com>
Subject: Re: Multiple Sound Streams out of a single card
Date: 14 Sep 2003 09:11:55 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1063555915.21172.17.camel@localhost>
References: <200309140606.h8E66UCi032132@oud>
	 <1063554637.21173.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1063554637.21173.11.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-09-14 at 08:50, AthlonRob wrote:

> I just tried it, though, and it didn't seem to want to work for me...

Well, I got it working.  Alsaplayer doesn't like playing output to alsa,
so I switched to aplay, and fixed my .asoundrc so as to define an IPC
(123? what's up with the IPC?) and to define a slave (hw:0,0).  I was
then able to use aplay to play multiple things at once.  Yeah!  :-)

XMMS crashes and burns when I tell it to use 'main' in the alsa plugin 
... I'll have to google about for that, I suppose.  Or figure out if I
can get mpg123 to play to alsa.

I'd still like to hear, though, if it is possible to get OSS emulation
to use the dmix plugin...

Rob




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
