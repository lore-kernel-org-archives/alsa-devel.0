From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: security hook missing in compat ioctl in 2.6.11-rc1-mm2
Date: Fri, 21 Jan 2005 02:09:35 +0200
Message-ID: <20050121000935.GA341@mellanox.co.il>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261489AbVAUAJa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050119213818.55b14bb0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>, ak@suse.de
Cc: Greg KH <greg@kroah.com>, tiwai@suse.de, mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
List-Id: alsa-devel@alsa-project.org

Hi!
Security hook seems to be missing before compat_ioctl in mm2.
And, it would be nice to avoid calling it twice on some paths.

Chris Wright's patch addressed this in the most elegant way I think,
by adding vfs_ioctl.

Accordingly, this change:

@@ -468,6 +496,11 @@ asmlinkage long compat_sys_ioctl(unsigne
 
  found_handler:
 	if (t->handler) {
+		/* RED-PEN how should LSM module know it's handling 32bit? */
+		error = security_file_ioctl(filp, cmd, arg);
+		if (error)
+			goto out_fput;
+
 		lock_kernel();
 		error = t->handler(fd, cmd, arg, filp);
 		unlock_kernel();

 from Andy's "some fixes" patch wont be needed.

Chris - are you planning to update your patch to -rc1-mm2?
I'd like to see this addressed, after this I believe logically
we'll get everything right, then I have a couple of small
cosmetic patches, and I believe we'll be set.

-- 
I dont speak for Mellanox.
