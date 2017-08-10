From: srinivas.kandagatla@linaro.org
Subject: [PATCH] conf/ucm: DB410c-HiFi: add CIC selection
Date: Thu, 10 Aug 2017 13:36:16 +0200
Message-ID: <20170810113616.4270-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id D837B2665D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 13:36:22 +0200 (CEST)
Received: by mail-io0-f172.google.com with SMTP id g35so8502675ioi.3
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 04:36:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds CIC selection controls which have been added recently to
the kernel to select mic source.

Without this patch user has to manually select the control to record
from DMIC or AMIC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 src/conf/ucm/DB410c/HiFi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/conf/ucm/DB410c/HiFi b/src/conf/ucm/DB410c/HiFi
index f9cbcf0..dcb7ac9 100644
--- a/src/conf/ucm/DB410c/HiFi
+++ b/src/conf/ucm/DB410c/HiFi
@@ -108,6 +108,7 @@ SectionDevice."Handset" {
 	EnableSequence [
 		cdev "hw:0"
 		cset "name='DEC1 MUX' ADC2"
+		cset "name='CIC1 MUX' AMIC"
 		cset "name='ADC2 Volume' 8"
 		cset "name='ADC2 MUX' INP2"
 	]
@@ -130,6 +131,7 @@ SectionDevice."Primarymic" {
 	EnableSequence [
 		cdev "hw:0"
 		cset "name='DEC1 MUX' ADC1"
+		cset "name='CIC1 MUX' AMIC"
 		cset "name='ADC1 Volume' 8"
 	]
 
@@ -150,6 +152,7 @@ SectionDevice."Secondarymic" {
 	EnableSequence [
 		cdev "hw:0"
 		cset "name='DEC1 MUX' ADC2"
+		cset "name='CIC1 MUX' AMIC"
 		cset "name='ADC2 Volume' 8"
 		cset "name='ADC2 MUX' INP2"
 	]
@@ -172,6 +175,7 @@ SectionDevice."DMIC" {
 	EnableSequence [
 		cdev "hw:0"
 		cset "name='DEC1 MUX' DMIC1"
+		cset "name='CIC1 MUX' DMIC"
 	]
 
 	DisableSequence [
-- 
2.9.3
