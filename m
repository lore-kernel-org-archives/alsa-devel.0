From: Mike Crowe <drmikecrowe@gmail.com>
Subject: Driver debugging help: OSS emulation and different
	results
Date: Wed, 25 May 2011 20:22:11 -0400
Message-ID: <BANLkTimtNy8uYD9Y5ez=r=ieKchn7EAU_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 143F7103856
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 02:22:34 +0200 (CEST)
Received: by pwi9 with SMTP id 9so113533pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2011 17:22:33 -0700 (PDT)
Received: by pzk26 with SMTP id 26so81041pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2011 17:22:32 -0700 (PDT)
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

Hi folks,

I know this is vague, and probably not worthy of this list.  However, I'm
struggling with where to go next.

Here's the deal:

   - I have an embedded system where we have developed the soc driver, and
   it appears to be working fine
   - We have a VoIP library we are integrating, and only have object files
   and almost no support
   - The VoIP library uses OSS interface with our hardware
   - We validated our hardware using vrec/vplay, both OSS applications.
    They record and play fine (as does the ALSA arecord/aplay as well)
   - I have the output (playback) working on the VoIP library side, but the
   recording is choppy (though seems to be at the right frequency now)

So, what I need to do next is try and understand how the library is opening
OSS differently from vrec/vplay.  However, I'm not sure where to start.

Can somebody give me a high level pointer as to how to add some debugging
output to my system to capture what is different between these two sessions?
 Where should I start?

TIA
Mike
