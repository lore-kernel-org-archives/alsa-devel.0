From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: ALSA calls don't work within  Mozilla plug-ins
Date: Tue, 23 Aug 2011 13:22:11 +0200
Message-ID: <4E538D63.13402.E803A1@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 923F224652
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 13:22:15 +0200 (CEST)
Content-description: Mail message body
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

I'm trying to develop a Mozilla plug-in that display and plays music scores. 
The music rendering module uses ALSA for sound (pcm) output.

It seems that, when called from a Mozilla plug-in, any ALSA function that gets 
a pointer as parameter either crashes or returns wrong values.

I made a very simple test plug-in from the "Basic Plugin" source code provided 
by Mozilla (I can provide the full project if needed). Here is what happens:

- Calling "snd_asoundlib_version" works

- Calling "snd_device_name_hint" crashes

- If the browser runs in super-user mode (sudo firefox), all works fine.

- If I load the plug-in (which is a shared library) from a program of my own 
and call the test function, it works.

Does anyone have any idea about what could cause this issue?
Could it be related to access rights or memory allocation/mapping?

I'm using: 
Ubuntu 11.04
Firefox 6.0
ALSA 1.0.24.1

I'm really stuck here, any advice would be highly appreciated.
Thank you,
Olivier

Olivier Guillion
Myriad
26 rue Michel de Montaigne
31200 Toulouse 
FRANCE
--------      WebSite    -----------
http://www.myriad-online.com
Download here the latest version of our shareware programs, view the online 
tutorials or get info about Myriad and its activities.
---------------------------------
