From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 0/5] [RFC] ALSA ASoC Support for TLVaic23b
 audio codec
Date: Mon, 29 Sep 2008 12:07:53 -0700
Message-ID: <48E12789.50006@boundarydevices.com>
References: <dfeb90390809290241h2219ef57q2a7401aebf47efe5@mail.gmail.com>	<48E1068E.7020908@boundarydevices.com>	<20080929165404.GA16109@sirena.org.uk>	<48E10FEA.7000300@boundarydevices.com>	<20080929173937.GB18699@sirena.org.uk>	<48E11753.3090100@boundarydevices.com>
	<20080929183045.GA21010@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id CCB0A24502
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 21:08:10 +0200 (CEST)
In-Reply-To: <20080929183045.GA21010@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Sep 29, 2008 at 10:58:43AM -0700, Troy Kisky wrote:
> In the device model the board registers the *device*, the codec (or
> whatever) driver registers the *driver* - the two are separated.  The
> driver core then instantiates the drivers based on what the board
> specifies.  There's not really any overlap between the two areas that I
> can see.
> 
> Otherwise could you explain in more detail where you see the code
> duplication coming from?

My point, though admittedly a minor one, was that the I2C device
or spi device could be initialized before the codec is probed.

That would be moving code from codec files into board files.
Better would be moving the code into a common soc directory file.

+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+/*
+ * If the i2c layer weren't so broken, we could pass this kind of data
+ * around
+ */
+static int aic23_codec_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *i2c_id)
+{
+	struct snd_soc_device *socdev = aic23_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EINVAL;
+
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
....
+	ret = aic23_init(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "aic23: failed to initialise AIC23\n");
+		goto err;
+	}
... The above would move to codec probe

+	return ret;
+
+err:
+	kfree(codec);
+	kfree(i2c);
+	return ret;
+}
+static int __exit aic23_i2c_remove(struct i2c_client *i2c)
+{
+
+	put_device(&i2c->dev);
+	return 0;
+}
+
+static const struct i2c_device_id tlvaic23b_id[] = {
+	{"tlvaic23b", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, tlvaic23b_id);
+
+static struct i2c_driver aic23b_i2c_driver = {
+	.driver = {
+		   .name = "tlvaic23b",
+		   },
+	.probe = aic23_codec_probe,
+	.remove = __exit_p(aic23_i2c_remove),
+	.id_table = tlvaic23b_id,
+};
+
+#endif

If this code could be generalized to be useable by most
codecs, I think the code would look better. This is the
"almost" duplication to which I'm referring.


Troy
