From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/6] device property: Add new array helper
Date: Tue, 28 May 2019 16:43:07 +0100
Message-ID: <20190528154312.14435-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1AE15F896B8
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 17:43:15 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, rafael@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com, robh+dt@kernel.org, patches@opensource.cirrus.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

It is fairly common to want to read an integer array property
that is composed of an unknown number of fixed size integer
groups. For example, say each group consists of three values
which correspond to the settings for one input on the device
and the driver supports several chips with different numbers
of inputs.

Add a new helper function to provide this functionality, it
differs for the existing helpers in that it allows reading a
smaller number of values than the full array size and checks
that the number of values read is a multiple of the group size.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/property.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 348b37e64944c..656d21e01a648 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -133,6 +133,54 @@ int device_property_read_u32_array(struct device *dev, const char *propname,
 EXPORT_SYMBOL_GPL(device_property_read_u32_array);
 
 /**
+ * device_property_read_u32_2darray - return a 2d u32 array property of a device
+ * @dev: Device to get the property of
+ * @propname: Name of the property
+ * @val: The values are stored here or %NULL to return the number of values
+ * @nval: Size of the @val array
+ * @multiple: Number of entries in each block of data
+ *
+ * Function reads an array of u32 properties split up into fixed size
+ * sub-groups, with @propname from the device firmware description and
+ * stores them to @val if found.
+ *
+ * Return: Number of values read
+ *	   %0 if the property was not found,
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the property does not have a value,
+ *	   %-EPROTO if the property is not an array of numbers,
+ *	   %-EOVERFLOW if the size of the property is not as expected.
+ *	   %-ENXIO if no suitable firmware interface is present.
+ */
+int device_property_read_u32_2darray(struct device *dev, const char *propname,
+				     u32 *val, size_t nval, int multiple)
+{
+	int n, ret;
+
+	n = device_property_read_u32_array(dev, propname, NULL, 0);
+	if (n == -EINVAL) {
+		return 0;	/* missing, ignore */
+	} else if (n < 0) {
+		dev_warn(dev, "%s malformed (%d)\n", propname, n);
+		return n;
+	} else if ((n % multiple) != 0) {
+		dev_warn(dev, "%s not a multiple of %d entries\n",
+			 propname, multiple);
+		return -EOVERFLOW;
+	}
+
+	if (n > nval)
+		n = nval;
+
+	ret = device_property_read_u32_array(dev, propname, val, n);
+	if (ret < 0)
+		return ret;
+	else
+		return n;
+}
+EXPORT_SYMBOL_GPL(device_property_read_u32_2darray);
+
+/**
  * device_property_read_u64_array - return a u64 array property of a device
  * @dev: Device to get the property of
  * @propname: Name of the property
diff --git a/include/linux/property.h b/include/linux/property.h
index a29369c89e6ef..854867f0d139f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -43,6 +43,8 @@ int device_property_read_u16_array(struct device *dev, const char *propname,
 				   u16 *val, size_t nval);
 int device_property_read_u32_array(struct device *dev, const char *propname,
 				   u32 *val, size_t nval);
+int device_property_read_u32_2darray(struct device *dev, const char *propname,
+				   u32 *val, size_t nval, int multiple);
 int device_property_read_u64_array(struct device *dev, const char *propname,
 				   u64 *val, size_t nval);
 int device_property_read_string_array(struct device *dev, const char *propname,
-- 
2.11.0
