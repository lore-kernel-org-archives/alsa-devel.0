From: Rob Nertney <rob@rob-otics.com>
Subject: Stale data interleaved in capture driver
Date: Sun, 31 Jul 2016 22:26:58 -0700
Message-ID: <CALAeOVO94y6R6bZOWK=2TfEckyVUxRXBMcOtXWvuoO5oG_4V4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B53A4265873
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 07:26:59 +0200 (CEST)
Received: by mail-vk0-f46.google.com with SMTP id n129so91550345vke.3
 for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2016 22:26:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My DMA is configured with a debug mode in which it sends an a simple
increasing counter value in the format I wish to receive: an IRQ every
32Bytes (half-frame). it transfers 32KBytes of data, and then restarts from
it's original offset. This is tested in bare-metal mode as working.

I wrote my handler as described in the high-frequency interrupts described
here:
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s07.html

My data is valid until 1/4 buffer full, then it interleaves stale (lower
numbers) in, replacing the desired numbers. It's sporadic, and it appears
to repeat, as if ALSA never returns to the 0-offset of dma_area.  I've
dumped a snip below. If the formatting is lost, I can post a google drive
or an image somewhere.

Thanks,
Rob

00004000: 8182 8183 8184 8185 00004008: 8186 8187 8188 8189 00004010: 8190
8191 8192 1 00004018: 2 3 4 5 00004020: 6 7 8 8201 00004028: 8202 8203 8204
8205 00004030: 8206 8207 8208 8209 00004038: 8210 8211 8212 8213 00004040:
8214 8215 8216 8217 00004048: 8218 8219 8220 8221 00004050: 8222 8223 8224
8225 00004058: 8226 8227 8228 8229 00004060: 8230 8231 8232 8233 00004068:
8234 8235 8236 8237 00004070: 8238 8239 8240 49 00004078: 50 51 52 53
00004080: 54 55 56 8249 00004088: 8250 8251 8252 8253 00004090: 8254 8255
8256 65 00004098: 66 67 68 69 000040a0: 70 71 72 73 000040a8: 74 75 76 77
000040b0: 78 79 80 8273 000040b8: 8274 8275 8276 8277 000040c0: 8278 8279
8280 8281 000040c8: 8282 8283 8284 8285 000040d0: 8286 8287 8288 8289
000040d8: 8290 8291 8292 8293 000040e0: 8294 8295 8296 8297 000040e8: 8298
8299 8300 8301 000040f0: 8302 8303 8304 8305 000040f8: 8306 8307 8308 8309
00004100: 8310 8311 8312 121
