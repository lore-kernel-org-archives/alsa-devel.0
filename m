From: Markus Gaugusch <markus@gaugusch.at>
Subject: Compile ALSA into the kernel
Date: Tue, 6 Jan 2004 20:48:51 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401062042310.1739@phoenix.kerstin.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm using software suspend (swsusp.sf.net) and unfortunately the via82xx 
has no power management hooks (I posted some days ago). After resume the 
hardware is not-reinitialized and I can hear no sound. Therefore I thought 
that I could compile the driver into the kernel, so it gets re-initialized 
on resume.

Unfortunately I couldn't find any info on how to add the alsa modules to
the kernel. I tried with SuSE kernel sources, but ALSA is rather old there
(0.9.0cvs) and the kernel is also old (2.4.21, but alsa patches are 
against 2.4.18!). I'd like to patch against 2.4.23/24.
If I can't patch the kernel easily, it would probably sufficient to link 
the compiled object files with my kernel? But where shall I specify this 
and will it work?

thanks!
Markus

-- 
__________________    /"\ 
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus(at)gaugusch.at  X     Against HTML Mail
                      / \


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
