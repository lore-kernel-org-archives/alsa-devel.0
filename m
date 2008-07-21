From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: CS4279 and hw_read_t/hw_write_t
Date: Mon, 21 Jul 2008 11:06:29 -0400
Message-ID: <9e4733910807210806v4caf49f1ke90cefda07b63579@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id A7BB92438D
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 17:06:32 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so204450yxh.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2008 08:06:29 -0700 (PDT)
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
To: ALSA-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

>From soc/codecs/cs4270.c...

 *
 * Note that we don't use the hw_write function pointer of snd_soc_codec.
 * That's because it's too clunky: the hw_write_t prototype does not match
 * i2c_smbus_write_byte_data(), and it's just another layer of overhead.
 */

The prototype doesn't match because you are using
i2c_smbus_write_byte_data() instead of
i2c_master_send()/i2c_master_recv().


-- 
Jon Smirl
jonsmirl@gmail.com
