From: Cliff Cai <cliffcai.sh@gmail.com>
Subject: soc-cache problem
Date: Fri, 15 Jan 2010 15:12:13 +0800
Message-ID: <da1989291001142312g24d66135n903f87983e733532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AAE0224158
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 08:12:14 +0100 (CET)
Received: by pzk9 with SMTP id 9so396631pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 23:12:13 -0800 (PST)
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

Hi all,

Nowadays, soc tries to  set up standard I/O functions with same
addr_bits and data_bits for a codec.
My problem is some codec might have registers with different data
length.i.e.ADAU1761,
Most of its registers are 8 bits long except PLL register,which is a 8
bytes long one.In order to set/read PLL ,
 a block of data(8 bytes) needs to be transfer to/from the PLL
register  at a time.

So, if soc-cache needs to consider this kind of case, or just keep it
in local driver?

Thanks

Cliff
