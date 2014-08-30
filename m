From: Dana Goyette <DanaGoyette@gmail.com>
Subject: ALC1150 broken on SuperMicro X10SAT
Date: Sat, 30 Aug 2014 13:20:59 -0700
Message-ID: <lttbnc$7ck$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 50733261696
 for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2014 22:21:19 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1XNp9C-0003ho-P2
 for alsa-devel@alsa-project.org; Sat, 30 Aug 2014 22:21:18 +0200
Received: from 173-228-55-68.static.sonic.net ([173.228.55.68])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2014 22:21:18 +0200
Received: from DanaGoyette by 173-228-55-68.static.sonic.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2014 22:21:18 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On my SuperMicro X10SAT, the ALC1150 audio codec has horrific audio 
quality by default.  The only output that seems to work is the front 
channel, and it's quiet, distorted, and unbalanced (the right is louder 
than the left).

alsa-info.sh output: 
http://www.alsa-project.org/db/?f=8fbcab1d61590060ceddc1e63eb00d508e94d731

I've gotten the audio to work by guessing a model:
options snd-hda-intel model=auto,acer-aspire,auto

In tracing through the source:
{.id = ALC883_FIXUP_ACER_EAPD, .name = "acer-aspire"}
This name leads to:
[ALC883_FIXUP_ACER_EAPD] = {
         .type = HDA_FIXUP_VERBS,
         .v.verbs = (const struct hda_verb[]) {
                 /* eanable EAPD on Acer laptops */
                 { 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
                 { 0x20, AC_VERB_SET_PROC_COEF, 0x3050 },
                 { }
         }
},
There's another override I did not try, since it has no model= name:
[ALC883_FIXUP_EAPD] = {
         .type = HDA_FIXUP_VERBS,
         .v.verbs = (const struct hda_verb[]) {
                 /* change to EAPD mode */
                 { 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
                 { 0x20, AC_VERB_SET_PROC_COEF, 0x3070 },
                 { }
         }
},
