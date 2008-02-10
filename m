From: Balaji Rao <balajirrao@gmail.com>
Subject: support for jackSense feature in modern sound cards
Date: Mon, 11 Feb 2008 01:03:37 +0530
Message-ID: <200802110103.37082.balajirrao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 8307710389E
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2008 20:38:28 +0100 (CET)
Received: by hs-out-2122.google.com with SMTP id l65so3991943hsc.0
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2008 11:38:27 -0800 (PST)
Content-Disposition: inline
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

Hello people,

How well is the jack sense feature in modern soundcards supported in the 
kernel ? I opened up a few driver sources like hda-intel and found the 
word 'jack sense' in some files, but i could not find it being used anywhere.

Are there standard interfaces in kmix or equivalent software that use the jack 
sense feature ? If not, wouldn't it be nice to have a standard interface to 
expose this feature so that kmix and others could make use of in a device 
independent way ?

If yes, I would be more than willing to contribute to its development.

Please clarify.

-- 
regards,
balaji rao
