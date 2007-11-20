From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH 2/2] caiaq/NativeInstruments: control support
Date: Tue, 20 Nov 2007 14:32:10 +0100
Message-ID: <20071120133210.GA4425@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 901E6249FE
	for <Alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 14:32:15 +0100 (CET)
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
To: Alsa-devel@alsa-project.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch adds support for input controllers on "Kore controller"
and uses ALSA's control API to enable LED switching on several hardware
products as well as some internal audio related functions of 
"Audio 8 DJ".

Subject: SOUND: caiaq - add control API and more input features
From: Daniel Mack <daniel@caiaq.de>

SOUND: caiaq - add control API and more input features

 - added support for all input controllers on Native Instrument's "Kore
   controller".
 - added ALSA controls to switch LEDs on "RigKontrol 2", "RigKontrol3",
   "Audio Kontrol 1" and "Kore controller".
 - added ALSA controls to switch input mode, software lock and ground
   lift features on "Audio 8 DJ".
 
Signed-off-by: Daniel Mack <daniel@caiaq.de>
