From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Bug in emu10k1 multichannel support
Date: Fri, 11 Feb 2005 13:41:10 -0500
Message-ID: <1108147270.20365.0.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <s5hpt01tler.wl@alsa2.suse.de> <1106970885.3051.88.camel@krustophenia.net>
	 <41FE5838.4060907@glocalnet.net>
	 <1108073865.11177.6.camel@krustophenia.net>
	 <420BED90.8090609@glocalnet.net>
	 <1108086929.16531.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108086929.16531.2.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-02-10 at 20:55 -0500, Lee Revell wrote:
> On Fri, 2005-02-11 at 00:26 +0100, Mikael Magnusson wrote:
> > I'm still having the same problem with emu10k1-multichannel-v009.patch 
> > and current CVS.
> > 
> 
> Thanks, I verified the bug is still there in 009.  I must have screwed
> up the patch, because I'm sure I fixed it.  I will post version 010
> soon.
> 

Please try this patch, on top of 009.

Lee

--- ../../alsa-v009-test/alsa-kernel/pci/emu10k1/voice.c	2005-02-10 16:55:56.000000000 -0500
+++ alsa-kernel/pci/emu10k1/voice.c	2005-02-06 05:16:49.000000000 -0500
@@ -48,47 +48,50 @@
 static int voice_alloc(emu10k1_t *emu, emu10k1_voice_type_t type, int number, emu10k1_voice_t **rvoice)
 {
 	emu10k1_voice_t *voice;
-	int idx, pair, i, j, k, first_voice, last_voice, skip;
+	int i, j, k, first_voice, last_voice, skip;
 
-	first_voice = last_voice = skip = 0;	
 	*rvoice = NULL;
-	for (i = emu->next_free_voice, j=0; j < NUM_G ; i += number, j+= number) {
+	first_voice = last_voice = 0;
+	for (i = emu->next_free_voice, j = 0; j < NUM_G ; i += number, j += number) {
 		// printk("i %d j %d next free %d!\n", i, j, emu->next_free_voice);
 		i %= NUM_G;
-		if ((i % 2) && (number == 2)) {
+
+		/* stereo voices must be even/odd */
+		if ((number == 2) && (i % 2)) {
 			i++;
 			continue;
 		}
 			
 		/* make sure the block of voices does not cross the 32 voice boundary */
-		if (((i % 32) + number) > 32)
-			continue;
+		//if (((i % 32) + number) > 32)
+		//	continue;
+
+		skip = 0;
 		for (k = 0; k < number; k++) {
-			voice = &emu->voices[i+k];
+			voice = &emu->voices[(i+k) % NUM_G];
 			if (voice->use) {
-				// printk("voice %d: use=1!\n", i+k);
+				printk("voice %d: use=1!\n", i+k);
 				skip = 1;
 			}
 		}
 		if (!skip) {
 			// printk("allocated voice %d\n", i);
 			first_voice = i;
-			last_voice = i + number;
+			last_voice = (i + number) % NUM_G;
 			emu->next_free_voice = last_voice;
-			emu->next_free_voice %= NUM_G;
 			break;
 		}
 	}
 	
 	if (first_voice == last_voice) {
-		printk("first==last, number %d, next free %d!\n", number, emu->next_free_voice);
-		/* BUG (or not enough voices)! */
+		printk("BUG (or not enough voices), number %d, next free %d!\n",
+				number,
+				emu->next_free_voice);
 		return -ENOMEM;
 	}	
 	
-	pair = ( number == 2 ) ? 1 : 0;
-	for (idx=first_voice; idx < last_voice; idx++) {
-		voice = &emu->voices[idx];
+	for (i=0; i < number; i++) {
+		voice = &emu->voices[(first_voice + i) % NUM_G];
 		// printk("voice alloc - %i, %i of %i\n", voice->number, idx-first_voice+1, number);
 		voice->use = 1;
 		switch (type) {




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
