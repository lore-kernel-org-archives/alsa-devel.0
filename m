From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1
 emu10k1_main.c,1.38,1.39
Date: Tue, 30 Nov 2004 20:59:25 -0500
Message-ID: <1101866365.5190.21.camel@krustophenia.net>
References: <E1CUneY-00058G-AN@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1CUneY-00058G-AN@sc8-pr-cvs1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@users.sourceforge.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-11-18 at 06:52 -0800, Takashi Iwai wrote:
> Update of /cvsroot/alsa/alsa-kernel/pci/emu10k1
> In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv19661/pci/emu10k1
> 
> Modified Files:
> 	emu10k1_main.c 
> Log Message:
> Summary: Add pci_disable_device() to removal and error paths
> 
> pci_disable_device() is called properly in the removal and error
> paths.  Also, the pci_set_master() is added to the resume callbacks if
> missing (just to be sure).
> 

OK, this change was committed almost two weeks ago.  But it is still not
visible in Sourceforge anonymous CVS.  The latest version is 1.39:

> retrieving revision 1.38
> retrieving revision 1.39
> diff -u -r1.38 -r1.39

But cvs diff on my system shows this:

rlrevell@mindpipe:~/cvs/alsa-cvs-T3$ cvs diff
alsa-kernel/pci/emu10k1/emu10k1_main.c
Index: alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.38
diff -u -r1.38 emu10k1_main.c

Any idea what's going on?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
