From: "John Kacur" <jkacur@gmail.com>
Subject: define confusion
Date: Tue, 14 Oct 2008 13:41:22 +0200
Message-ID: <520f0cf10810140441n33664dedp1ea441f6458ea964@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C6C0244CD
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 13:41:40 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so1255766waf.16
	for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2008 04:41:22 -0700 (PDT)
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

Could someone explain this a little bit more pls? The comment at the
top doesn't clarify it for me!

Thanks in advance.

/*
 * DAI hardware clock masters
 * This is wrt the codec, the inverse is true for the interface
 * i.e. if the codec is clk and frm master then the interface is
 * clk and frame slave.
 */
#define SND_SOC_DAIFMT_CBM_CFM	(0 << 12) /* codec clk & frm master */
#define SND_SOC_DAIFMT_CBS_CFM	(1 << 12) /* codec clk slave & frm master */
#define SND_SOC_DAIFMT_CBM_CFS	(2 << 12) /* codec clk master & frame slave */
#define SND_SOC_DAIFMT_CBS_CFS	(3 << 12) /* codec clk & frm slave */
