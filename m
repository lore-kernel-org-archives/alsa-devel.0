From: Paul Davis <pbd@op.net>
Subject: Re: unitor8/amt8 driver for alsa 0.9.0rc1
Date: Sat, 04 May 2002 07:39:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E173xsT-0002VV-00@usw-sf-list1.sourceforge.net>
References: <006901c1f110$84014110$0400a8c0@martijn>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 01 May 2002 14:02:33 BST."
             <006901c1f110$84014110$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martijn Sipkema <m.j.w.sipkema@student.tudelft.nl>
Cc: Manush Dodunekov <manush@stendahls.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>How does this work then? Can a file be opened from kernel space? Or

sys_{open,read,write,ioctl,close} can be called from kernel space.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
