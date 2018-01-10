From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "docs: driver-api: add iio hw consumer section" to the asoc tree
Date: Wed, 10 Jan 2018 11:13:39 +0000
Message-ID: <E1eZEKB-00053k-9T@debutante>
References: <1511881557-28596-3-git-send-email-arnaud.pouliquen@st.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511881557-28596-3-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   docs: driver-api: add iio hw consumer section

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5b178943d64b85d78350ea9c86344c376d7bfe74 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Date: Wed, 10 Jan 2018 11:13:04 +0100
Subject: [PATCH] docs: driver-api: add iio hw consumer section

This adds a section about the Hardware consumer
API of the IIO subsystem to the driver API
documentation.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/driver-api/iio/hw-consumer.rst | 51 ++++++++++++++++++++++++++++
 Documentation/driver-api/iio/index.rst       |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/driver-api/iio/hw-consumer.rst

diff --git a/Documentation/driver-api/iio/hw-consumer.rst b/Documentation/driver-api/iio/hw-consumer.rst
new file mode 100644
index 000000000000..8facce6a6733
--- /dev/null
+++ b/Documentation/driver-api/iio/hw-consumer.rst
@@ -0,0 +1,51 @@
+===========
+HW consumer
+===========
+An IIO device can be directly connected to another device in hardware. in this
+case the buffers between IIO provider and IIO consumer are handled by hardware.
+The Industrial I/O HW consumer offers a way to bond these IIO devices without
+software buffer for data. The implementation can be found under
+:file:`drivers/iio/buffer/hw-consumer.c`
+
+
+* struct :c:type:`iio_hw_consumer` — Hardware consumer structure
+* :c:func:`iio_hw_consumer_alloc` — Allocate IIO hardware consumer
+* :c:func:`iio_hw_consumer_free` — Free IIO hardware consumer
+* :c:func:`iio_hw_consumer_enable` — Enable IIO hardware consumer
+* :c:func:`iio_hw_consumer_disable` — Disable IIO hardware consumer
+
+
+HW consumer setup
+=================
+
+As standard IIO device the implementation is based on IIO provider/consumer.
+A typical IIO HW consumer setup looks like this::
+
+	static struct iio_hw_consumer *hwc;
+
+	static const struct iio_info adc_info = {
+		.read_raw = adc_read_raw,
+	};
+
+	static int adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+	{
+		ret = iio_hw_consumer_enable(hwc);
+
+		/* Acquire data */
+
+		ret = iio_hw_consumer_disable(hwc);
+	}
+
+	static int adc_probe(struct platform_device *pdev)
+	{
+		hwc = devm_iio_hw_consumer_alloc(&iio->dev);
+	}
+
+More details
+============
+.. kernel-doc:: include/linux/iio/hw-consumer.h
+.. kernel-doc:: drivers/iio/buffer/industrialio-hw-consumer.c
+   :export:
+
diff --git a/Documentation/driver-api/iio/index.rst b/Documentation/driver-api/iio/index.rst
index e5c3922d1b6f..7fba341bd8b2 100644
--- a/Documentation/driver-api/iio/index.rst
+++ b/Documentation/driver-api/iio/index.rst
@@ -15,3 +15,4 @@ Contents:
    buffers
    triggers
    triggered-buffers
+   hw-consumer
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
