From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Removal of /proc/asound ?
Date: Tue, 20 May 2003 01:36:00 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC907F0.9060208@boosthardware.com>
References: <20030517081625.6ef24458.erikd-alsa@mega-nerd.com>	<Pine.LNX.4.44.0305171343140.21997-100000@pnote.perex-int.cz>	<20030518081331.7b9eca31.erikd-alsa@mega-nerd.com> <s5h4r3re0a8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>How will this work if the user does not have a DEVFS enabled kernel?
> 
> 
> run snddevices script once.  that's all.
> 

Phew. Picked this thread up late but here you allay my fears. basically 
if you don't run ./snddevices you get devfs and if you do you get proc.

This seems to have been working for a while (like 6 months or more). Is 
there more to this than meets the eye???





-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
