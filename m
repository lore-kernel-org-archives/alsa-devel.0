From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: Firewire Audio Support
Date: Thu, 28 Aug 2003 08:13:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030828071308.GD8408@ecs.soton.ac.uk>
References: <2689281.1062002361328.JavaMail.nobody@wamui09.slb.atl.earthlink.net> <1062033984.4389.328.camel@maze.mythral.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1062033984.4389.328.camel@maze.mythral.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 27, 2003 at 06:26:24PM -0700, Ray Heasman wrote:
> Have you looked here? : http://www.linux1394.org/amdtp.html
> 
> It looks like they are doing it the way I did - simple user-land access
> to an interface that gives you raw access to the bus.

This is great. Theres a /dev/ node that you can write to and use ioctls to
configure it. Sadly its limited to 16bit at the moment. It also doesnt do
capture yet.

- Steve


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
