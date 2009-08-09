From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Problems with gain controls
Date: Sun, 9 Aug 2009 11:28:46 +0100
Message-ID: <ad2655cb0908090328j3e3dff83p68f7d55060590326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DF6824354
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 12:28:48 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so581165fga.21
	for <alsa-devel@alsa-project.org>; Sun, 09 Aug 2009 03:28:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Does anyone know how to disable pulse from making any changes to the
alsa hardware mixer controls?
I would prefer pulse to use software gain controls, and not touch the
alsamixer levels.
pulse seems to do a very bizarre thing. The single master gain control
 within pulse changes both the alsamixer PCM and Master controls.

Kind Regards

James
