From: parna.naveenkumar@gmail.com
Subject: [PATCH] sound: open brace should be on the previous line
Date: Fri, 17 May 2019 12:03:28 +0530
Message-ID: <20190517063328.21512-1-parna.naveenkumar@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Naveen Kumar Parna <parna.naveenkumar@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

Resolved open brace { should be on the previous line checkpatch.pl
error. While addressing this error, also corrected the affected code
for below mentioned checkpatch errors.

ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '==' (ctx:VxV)
ERROR: space required before the open parenthesis '('

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 sound/sound_core.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 40ad000c2e3c..ce794a2afc6b 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -111,8 +111,7 @@ module_exit(cleanup_soundcore);
 
 #define SOUND_STEP 16
 
-struct sound_unit
-{
+struct sound_unit {
 	int unit_minor;
 	const struct file_operations *unit_fops;
 	struct sound_unit *next;
@@ -151,8 +150,7 @@ module_param(preclaim_oss, int, 0444);
 
 static int soundcore_open(struct inode *, struct file *);
 
-static const struct file_operations soundcore_fops =
-{
+static const struct file_operations soundcore_fops = {
 	/* We must have an owner or the module locking fails */
 	.owner	= THIS_MODULE,
 	.open	= soundcore_open,
@@ -173,8 +171,7 @@ static int __sound_insert_unit(struct sound_unit * s, struct sound_unit **list,
 		while (*list && (*list)->unit_minor<n)
 			list=&((*list)->next);
 
-		while(n<top)
-		{
+		while (n < top) {
 			/* Found a hole ? */
 			if(*list==NULL || (*list)->unit_minor>n)
 				break;
@@ -219,11 +216,9 @@ static int __sound_insert_unit(struct sound_unit * s, struct sound_unit **list,
  
 static struct sound_unit *__sound_remove_unit(struct sound_unit **list, int unit)
 {
-	while(*list)
-	{
+	while (*list) {
 		struct sound_unit *p=*list;
-		if(p->unit_minor==unit)
-		{
+		if (p->unit_minor == unit) {
 			*list=p->next;
 			return p;
 		}
@@ -528,8 +523,7 @@ static struct sound_unit *__look_for_unit(int chain, int unit)
 	struct sound_unit *s;
 	
 	s=chains[chain];
-	while(s && s->unit_minor <= unit)
-	{
+	while (s && s->unit_minor <= unit) {
 		if(s->unit_minor==unit)
 			return s;
 		s=s->next;
@@ -545,8 +539,7 @@ static int soundcore_open(struct inode *inode, struct file *file)
 	const struct file_operations *new_fops = NULL;
 
 	chain=unit&0x0F;
-	if(chain==4 || chain==5)	/* dsp/audio/dsp16 */
-	{
+	if (chain == 4 || chain == 5) {	/* dsp/audio/dsp16 */
 		unit&=0xF0;
 		unit|=3;
 		chain=3;
-- 
2.17.1
