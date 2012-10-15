From: Paul <paul@redpineinstruments.org>
Subject: snd_ctl_elem_list
Date: Mon, 15 Oct 2012 01:09:40 -0400
Message-ID: <507B9A94.4020200@redpineinstruments.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zeus.kos.net (zeus.kos.net [199.246.2.50])
 by alsa0.perex.cz (Postfix) with SMTP id 07868264EF9
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2012 07:09:42 +0200 (CEST)
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

Newbie. Trying to discover information about the audio hardware. 
Specifically about a USB microphone ( Audio-Technia AT2020USB ) and 
whether it has a volume control. Writing in Ada just to be difficult. 
Not having any problems with that though.

After doing a malloc and a snd_ctl_elem_list I can use 
ctl_elem_list_count to get the number of elements. This number is 
non-zero ( 2 for the AT2020, 34 for the on-board Intel audio chip  ).

Then I can use ctl_elem_to get the number of used. That number is zero 
and prevents me from trying to access the element list.

How can I find out information about the elements in the list? How do 
these elements become used? Is this even the correct path to try to 
discover the volume control?

Thanks,

Paul I
