From: Robert Bielik <Robert.Bielik@dirac.com>
Subject: LADSPA ALSA plugin
Date: Tue, 18 Jul 2017 08:52:46 +0000
Message-ID: <8d841eb6e1e742c7a83ac95cdfb946c1@hosted3-mb01.itm.host>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp03.itmastaren.net (smtp03.itmastaren.net [81.94.160.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 48948266C40
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 10:52:54 +0200 (CEST)
Received: from exchange.itm.host (smtp03.itmastaren.net [81.94.160.102])
 by smtp03.itmastaren.net (Postfix) with ESMTP id 3A4C0E0C1C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 10:52:54 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

Started experimenting with using LADSPA plugins with the ALSA LADSPA PCM plugin, and it works nicely. However, it seems only the PCM is interface is exposed from the plugin.
Question is if there is a way to expose the LADSPA plugin parameters directly to alsamixer ?

Regards
/Rob
