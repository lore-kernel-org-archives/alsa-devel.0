From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: asihpi: fix an information leak in asihpi_hpi_ioctl()
Date: Mon, 22 Dec 2014 10:49:46 +0300
Message-ID: <20141222074946.GA9737@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

So far as I can see "hr->h.size" is set to "res_max_size" which is a
user controlled value between 12 and USHRT_MAX.  If it's larger than
sizeof(*hr), then that leads to an information leak.

I am not very familiar with this code, my other question here is that
on lines before we set "hr->h.size = sizeof(hr->h)".  It think this is
a bug.  I also think this particular code is never executed and I added
a comment to that effect.  But we do it in earlier in the function as
well:

	copy_to_user(puhr, hr, sizeof(hr->h));

It doesn't make sense to me.

Anyway, I think my patch is safe and it seems to fix a real information
leak.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 6aa677e..f88109a 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -283,6 +283,7 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		goto out;
 	}
 
+	/* FIXME:  isn't this a no-op? */
 	if (hr->h.size > res_max_size) {
 		HPI_DEBUG_LOG(ERROR, "response too big %d %d\n", hr->h.size,
 			res_max_size);
@@ -290,6 +291,9 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		hr->h.specific_error = hr->h.size;
 		hr->h.size = sizeof(hr->h);
 	}
+	/* prevent an information leak */
+	if (hr->h.size > sizeof(*hr))
+		hr->h.size = sizeof(*hr);
 
 	uncopied_bytes = copy_to_user(puhr, hr, hr->h.size);
 	if (uncopied_bytes) {
