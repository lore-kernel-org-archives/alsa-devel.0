From: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Subject: Problem adding support for digital mixer in codec
Date: Wed, 24 Mar 2010 21:33:54 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B904BD8A0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 105A9103889
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 03:33:59 +0100 (CET)
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2P2XuMd001610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 21:33:56 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o2P2XuLi016851
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 21:33:56 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2P2Xuen022019
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 21:33:56 -0500 (CDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to add support for a digital mixer. The digital mixer is
connected like the following example:

  
Path 1 -------\
Path 2 --------\
		    MIXER ------> DAC----> ...
Path 3 --------/
Path 4 -------/



However, I think ALSA does not support this configuration, as the DAC
should be the first element in a route. I tried adding the DAC to the
route first, and connected its output to the mixer inputs, like this:

	  {"Mixer", "Multimedia Ext Switch", "HSDAC Left"},
        {"Mixer", "Multimedia Ext Switch", "HSDAC Right"},

        {"Mixer", "Voice Switch", "HSDAC Left"},
        {"Mixer", "Voice Switch", "HSDAC Right"},

        {"Mixer", "Multimedia Uplink Switch", "HSDAC Left"},
        {"Mixer", "Multimedia Uplink Switch", "HSDAC Right"},

        {"Mixer", "Multimedia Switch", "HSDAC Left"},
        {"Mixer", "Multimedia Switch", "HSDAC Right"},

But this does not seem to work. Can anyone give me some tips? Any comment
would be appreciated.

Thanks,
Jorge
