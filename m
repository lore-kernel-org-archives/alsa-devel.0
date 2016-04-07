From: "Harvey, Ryan" <Ryan.Harvey@cirrus.com>
Subject: Checkpatch warnings on switch case fallthru
Date: Thu, 7 Apr 2016 22:23:03 +0000
Message-ID: <D32C47F6.1E2FD%ryan.harvey@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A990260824
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 00:23:06 +0200 (CEST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u37MJVQw030394
 for <alsa-devel@alsa-project.org>; Thu, 7 Apr 2016 17:23:04 -0500
Received: from mail2.cirrus.com (mail2.cirrus.com [141.131.128.20])
 by mx0b-001ae601.pphosted.com with ESMTP id 225vk88b0k-1
 for <alsa-devel@alsa-project.org>; Thu, 07 Apr 2016 17:23:04 -0500
Received: from ex4.ad.cirrus.com (ex4.ad.cirrus.com [141.131.36.35])
 by mail2.cirrus.com (Postfix) with ESMTP id 7E18EFC03F
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 17:23:09 -0500 (CDT)
Content-Language: en-US
Content-ID: <A83F192EE6985947A05C00785A34515C@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I receive a set of checkpatch warnings against my switch fallthru
structure in readable_registers().  I=B9m able to eliminate these warnings
with a preceding comment, but that does messy the code.  Is there a method
better than switch for accomplishing this?

static bool cs43130_readable_register(struct device *dev, unsigned int reg)
{
        switch (reg) {
        case CS43130_DEVID_AB ... CS43130_SYS_CLK_CTL_1:
        case CS43130_PWDN_CTL:
        case CS43130_PLL_SET_1 ... CS43130_PLL_SET_6:
        case CS43130_PLL_SET_7:
        case CS43130_PLL_SET_8:
        case CS43130_PLL_SET_9:
        case CS43130_PLL_SET_10:
        case CS43130_CLKOUT_CTL:
        case CS43130_ASP_NUM_1 ... CS43130_ASP_FRAME_CONF:
        case CS43130_HP_OUT_CTL_1:
        case CS43130_PCM_FILT_OPT ... CS43130_PCM_PATH_CTL_2:
        case CS43130_CLASS_H_CTL:
        case CS43130_HP_DETECT ... CS43130_HP_STATUS:
        case CS43130_HP_LOAD_1:
        case CS43130_HP_LOAD_STAT:
        case CS43130_INT_MASK_1 ... CS43130_INT_MASK_5:
                return true;
        default:
                return false;
        }
}


140: [WARNING] Possible switch case/default not preceeded by break or
fallthrough comment
+	case CS43130_PLL_SET_7:
141: [WARNING] Possible switch case/default not preceeded by break or
fallthrough comment
+	case CS43130_PLL_SET_8:
142: [WARNING] Possible switch case/default not preceeded by break or
fallthrough comment
+	case CS43130_PLL_SET_9:
143: [WARNING] Possible switch case/default not preceeded by break or
fallthrough comment
+	case CS43130_PLL_SET_10:
144: [WARNING] Possible switch case/default not preceeded by break or
fallthrough comment
+	case CS43130_CLKOUT_CTL:
152: [WARNING] Possible switch case/default not preceeded by break or
fallthrough comment
+	case CS43130_HP_OUT_CTL_1:
154: [WARNING] Possible switch case/default not preceeded by break or
fallthrough comment
+	case CS43130_CLASS_H_CTL:
156: [WARNING] Possible switch case/default not preceeded by break or
fallthrough comment
+	case CS43130_HP_LOAD_1:
160: [WARNING] Possible switch case/default not preceeded by break or
fallthrough comment
+	case CS43130_HP_LOAD_STAT:


Thanks
-Ryan
