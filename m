From: Klaus-Peter Schrage <kpschrage@gmx.de>
Subject: Re: alsa-drivers can't make on kernel 2.6 because of
 broken vx driver
Date: Tue, 06 Jan 2004 19:03:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FFAF856.2020901@gmx.de>
References: <1073392202.2633.4.camel@d51528079.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1073392202.2633.4.camel@d51528079.kabel.telenet.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kristof vansant <de_lupus@pandora.be>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Kristof vansant wrote:
> I don't know how alsa patches drivers when it has to compile on kernel
> 2.6, so I don't know how to fix it. 
> 
> I think lot of kernel 2.6 users would be gratefull if you fixed this
> issue. 
> 
>   CC [M]  /home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.o
> /home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.c:6:31:
> linux/modversions.h: Onbekend bestand of map

My Dutch is a bit rusty, but I guess the last line expresses that 
modversions.h is missing. As far as I remember, this is created during 
the kernel build process. So, is this a virgin kernel source which 
hasn't been configured and compiled yet?
Klaus



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
