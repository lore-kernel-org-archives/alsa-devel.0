From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: Failed to compile HDSP driver from the CVS -- solution?
Date: Tue, 14 May 2002 21:39:39 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000101c1fbb1$6127dc70$ac1f830a@ico>
References: <200205150001.g4F012T12698@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200205150001.g4F012T12698@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Paul Davis' <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hmmm, when I comment out the line 58 in the hammerfall_mem.c which says

MODULE_LICENSE("GPL");

Then everything compiles fine.

?

Ico




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
