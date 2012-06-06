From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/8] Rework KERN_<LEVEL>
Date: Tue, 05 Jun 2012 17:07:27 -0700
Message-ID: <1338941247.11962.16.camel@joe2Laptop>
References: <cover.1338889066.git.joe@perches.com>
	<20120605142826.d92316a0.akpm@linux-foundation.org>
	<1338934303.5780.8.camel@joe2Laptop>
	<20120605151754.a794ac7c.akpm@linux-foundation.org>
	<1338936572.5780.29.camel@joe2Laptop>
	<20120605162910.caccb0d4.akpm@linux-foundation.org>
	<1338939316.11962.3.camel@joe2Laptop>
	<CAPXgP13J+8-dPpZkSfh9sM3xXujC2Rb9tJaOvGoEPghgdr8jiw@mail.gmail.com>
	<1338939792.11962.4.camel@joe2Laptop>
	<CAPXgP10DEsqtz9xbPUQ3xCwdFGTTYyTGSd7yEcU2vUr3SJ83Sw@mail.gmail.com>
	<1338940345.11962.9.camel@joe2Laptop>
	<20120605165808.cd255b93.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 198F424393
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 02:07:30 +0200 (CEST)
In-Reply-To: <20120605165808.cd255b93.akpm@linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Kay Sievers <kay@vrfy.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-06-05 at 16:58 -0700, Andrew Morton wrote:
>  echo "\0014Hello Joe" > /dev/kmsg

# echo -e "\x014Hello Me" > /dev/kmsg
gives:
12,778,4057982669;Hello Me

#echo -e "\x011Hello Me_2" > /dev/kmsg
gives:
12,779,4140452093;Hello Me_2

I didn't change devkmsg_writev so the
original parsing style for "<.>" is
unchanged.

from printk.c:

static ssize_t devkmsg_writev(struct kiocb *iocb, const struct iovec *iv,
			      unsigned long count, loff_t pos)
[...]
	int level = default_message_loglevel;
[...]
	if (line[0] == '<') {
		char *endp = NULL;

		i = simple_strtoul(line+1, &endp, 10);
		if (endp && endp[0] == '>') {
			level = i & 7;
			if (i >> 3)
				facility = i >> 3;
			endp++;
			len -= endp - line;
			line = endp;
		}
	}
	line[len] = '\0';

	printk_emit(facility, level, NULL, 0, "%s", line);
[]

level is what matters.

from dmesg -r

<12>[ 2462.339252] \001Hello Andrew
<9>[ 2516.023444] Hello Andrew
<12>[ 3046.752764] \x01Hello Kay
<12>[ 3940.871850] \x01Hello Kay
<12>[ 4057.982669] Hello Me
<12>[ 4140.452093] Hello Me_2
