From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: Re: snd-powermac
Date: Tue, 1 Apr 2008 21:01:56 +0300
Message-ID: <46e1c7760804011101w41e613c5k5d84f31da692445a@mail.gmail.com>
References: <46e1c7760803290805i9f56637uce18036db7a6756d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 4267124A20
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Apr 2008 20:02:05 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so865033hsb.0
	for <alsa-devel@alsa-project.org>; Tue, 01 Apr 2008 11:02:01 -0700 (PDT)
In-Reply-To: <46e1c7760803290805i9f56637uce18036db7a6756d@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm experiencing an unpleasant situation when trying to test my
patches (for ALSA 1.0.16) with kernel 2.6.15. The snd-powermac module
cannot be unloaded. Or can, but after that the computer stops
responding before it can be shut down. A visible symptom of the
problem is two kernel messages:

Trying to free free IRQ17
Trying to free free IRQ9

The oddest is that the third, IRQ8, that is freed between the other
two, is ok. They are allocated and freed in the same order and manner
in alsa-kernel/ppc/pmac.c.

I had to do following patches to compile and load the module, maybe
the first one causes this, the second one is just to disable the
TOONIE case as the chip is moved out of the driver:

--- alsa-kernel/ppc/pmac.h.orig 2008-02-05 11:23:24.000000000 +0200
+++ alsa-kernel/ppc/pmac.h      2008-03-31 23:45:36.000000000 +0300
@@ -207,4 +207,11 @@

 int snd_pmac_add_automute(struct snd_pmac *chip);

+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,16)
+#define of_device_is_compatible(dev, s) device_is_compatible(dev, s)
+#define input_get_drvdata(dev) (dev->private)
+#define i2c_smbus_write_i2c_block_data(client, cmd, len, vals) \
+       i2c_smbus_write_block_data(client, cmd, len, vals)
+#endif
+
 #endif /* __PMAC_H */
--- ppc/pmac_old.c.orig 2008-02-05 11:23:23.000000000 +0200
+++ ppc/pmac_old.c      2008-03-31 19:35:58.000000000 +0300
@@ -997,12 +1003,14 @@
                        chip->can_byte_swap = 0; /* FIXME: check this */
                        chip->control_mask = MASK_IEPC | 0x11;/* disable IEE */
                        break;
+#ifdef SND_POWERMAC_SUPPORT_TOONIE
                case 0x3a:
                        chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
                        chip->model = PMAC_TOONIE;
                        chip->can_byte_swap = 0; /* FIXME: check this */
                        chip->control_mask = MASK_IEPC | 0x11;/* disable IEE */
                        break;
+#endif
                }
        }
        prop = (unsigned int *)get_property(sound, "device-id", NULL);
