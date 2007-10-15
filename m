From: Peter Skensved <peter@jay.phy.queensu.ca>
Subject: 1.0.15rc3 patch_analog.s bug + fix
Date: Sun, 14 Oct 2007 22:53:03 -0400
Message-ID: <20071015025303.GA17664@jay.phy.queensu.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jay.phy.queensu.ca (jay.phy.QueensU.CA [130.15.24.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 24C742441B
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Oct 2007 04:53:14 +0200 (CEST)
Received: from jay.phy.queensu.ca (localhost [127.0.0.1])
	by jay.phy.queensu.ca (8.13.8/8.13.8) with ESMTP id l9F2r3Nt020170
	for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2007 22:53:08 -0400
Received: (from peter@localhost)
	by jay.phy.queensu.ca (8.13.8/8.13.8/Submit) id l9F2r3jC020169
	for alsa-devel@alsa-project.org; Sun, 14 Oct 2007 22:53:03 -0400
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

     Hi,
  I've come across a problem with the 1.0.15rc3 alsa driver on my Lenovo 3000 N100 laptop using
the auto mute feature - it appears to work backwards !  Plugging in the headphones unmutes the
external speakers and unplugging the heaphones mutes them ...

  Changing the if statement in line ~600 in patch_analog.c in ad1986a_update_hp to

    if (!spec->jack_preset)

makes it work the intended way.  ( spec->jack_present changes state  _before_ the call to
ad1986a_hp_automute )

                                                              peter

----

Peter Skensved                          Email : peter@SNO.Phy.QueensU.CA
Dept. of Physics,
Queen's University,
Kingston, Ontario,
Canada
