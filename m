From: Reimundo <rheluani@gmail.com>
Subject: mic on macbook air
Date: Mon, 27 Sep 2010 00:32:03 +0200
Message-ID: <1285540323.2205.11.camel@vino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B935124536
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 00:33:35 +0200 (CEST)
Received: by wwb28 with SMTP id 28so4355493wwb.20
	for <alsa-devel@alsa-project.org>; Sun, 26 Sep 2010 15:33:35 -0700 (PDT)
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

Hello list, from time to time I spend some time trying to get the mic
working on a Macbook air 2,1. I tried looking at the relevant info from
the corresponding kernel extensions on mac os X. The codec has  "Vendor
Id: 0x10ec0885" so the relevant part of the info.plist on mac os X reads

<dict>
<key>MicAttributes</key>
<integer>28</integer>
<key>MicInfo</key>
<string>Sampled on rising edge</string>
<key>NodeID</key>
<integer>39</integer>
<key>PinConfigDefault</key>
<integer>2426405136</integer>
</dict>

Which tells me nothing. In particular I don't have a node 0x27=39 (at
least not that hda-analyzer sees) so it's not surprising that if I send
the corresponding verbs to set_config_default I don't get anything.
Also, I don't see how setting the pinconfigdefault could affect my not
having the mic working (anyway I tried setting those pinconfigdefaults
that put the node as a fixed mic on all nids 0x19-0x1c to no avail)

As for the sampled on rising edge, I don't know how to use this info.
any ideas?

Thanks,

R. 
