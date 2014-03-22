From: Brian McNeil <brian.mcneil@wikinewsie.org>
Subject: Edirol DA2496 and word clock sync
Date: Sat, 22 Mar 2014 14:05:45 +0000
Message-ID: <3338f6d11bdcc8371547f293771c556a@wikinewsie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node80.mtl.net.vexxhost.com
 (compute-199-19-213-171.ymq-zone1.thenebulacloud.com [199.19.213.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 54A07261622
 for <alsa-devel@alsa-project.org>; Sat, 22 Mar 2014 15:05:48 +0100 (CET)
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

Hello all; I'm new to the list, and sitting playing with a pair of 
Edirol DA2496 cards.

These support Word Clock synchronisation, which can be done using 
S/PDIF, a 75 ohm coax cable on the breakout boxes, or with a internal 
jumper cable between the PCI cards. Unfortunately neither the driver, or 
Mudita24, were exposing access to the Word Clock.

I've managed to patch support into both; doing so with the 3.12.13-rt21 
kernel, and mudita24-1.0.3+svn13 from the Ubuntu repositories. This is, 
mostly, by treating the cards the same as the Delta1010LT.

Forgive me being so rusty with C that I've not provided a patch; going 
to have to redo this and actually build proper diffs for it.

I do have a related query, about Xruns - when using an .asoundrc file to 
merge the two cards into a single virtual card - is there any way to 
properly suppress backend Xruns that have no impact on the actual 
recorded audio?



Brian McNeil
-- 
Wikinewsie.org | http://wikinewsie.org | https://en.wikinews.org
"Facts don't cease to be facts, but news ceases to be news."
GPG Fingerprint: 7C3D FFD5 5ED5 B80F 1D18 A52B E84C 8928 6ABC A7AD
