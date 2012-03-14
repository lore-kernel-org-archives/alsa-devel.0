From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Re: snd_seq_parse_address matching prefix
Date: Wed, 14 Mar 2012 11:48:05 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1203141147080.18589@anubis.informatik.uni-halle.de>
References: <alpine.DEB.2.00.1203132333121.5893@anubis.informatik.uni-halle.de>
	<s5hfwdblk37.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_dx9C1B7C1/q4+60DSLXJdQ)"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id 482391044BB
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 11:48:09 +0100 (CET)
In-reply-to: <s5hfwdblk37.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_dx9C1B7C1/q4+60DSLXJdQ)
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT


On Wed, 14 Mar 2012, Takashi Iwai wrote:

> Care to send a patch for the updated document?

attached is a proposal

--Boundary_(ID_dx9C1B7C1/q4+60DSLXJdQ)
Content-id: <alpine.DEB.2.00.1203141148050.18589@anubis.informatik.uni-halle.de>
Content-type: TEXT/x-diff; name=parse_address.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=parse_address.diff
Content-description: 

--- alsa-lib-1.0.22/src/seq/seqmid.c	2009-12-16 16:18:51.000000000 +0100
+++ alsa-lib-1.0.22-patched/src/seq/seqmid.c	2012-03-14 11:43:06.000000000 +0100
@@ -378,9 +378,18 @@
  * \return 0 on success or negative error code
  *
  * This function parses the sequencer client and port numbers from the given string.
- * The client and port tokes are separated by either colon or period, e.g. 128:1.
+ * The client and port tokens are separated by either colon or period, e.g. 128:1.
  * When \a seq is not NULL, the function accepts also a client name not only
  * digit numbers.
+ * Actually \a arg need to be only a prefix of the wanted client.
+ * That is, if a client named "Foobar XXL Master 2012" with number 128 is available,
+ * then parsing "Foobar" will return the address 128:0.
+ * However parsing is biased towards small client numbers,
+ * thus if also a client named "Foobar" with number 129 exists,
+ * then parsing will still yield address 128:0 and not 129:0.
+ * If you want be able to access all clients by prefixes
+ * then you must write your own parser that checks for matching client names
+ * in the order of increasing name lengths.
  */
 int snd_seq_parse_address(snd_seq_t *seq, snd_seq_addr_t *addr, const char *arg)
 {

--Boundary_(ID_dx9C1B7C1/q4+60DSLXJdQ)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary_(ID_dx9C1B7C1/q4+60DSLXJdQ)--
