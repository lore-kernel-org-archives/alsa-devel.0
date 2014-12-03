From: "Corfu, Valentin  (Wind River)" <valentinx.corfu@intel.com>
Subject: [alsa-dev] Variable latency issue in alsa-jack-plugins
Date: Wed, 3 Dec 2014 13:10:07 +0000
Message-ID: <9900E8BE2ADAAB43B2A4471493EDB7F913FB4E7A@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C246926044F
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 14:10:49 +0100 (CET)
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

Hello guys,

I recently encountered a problem about variable latency in alsa-jack-plugin.

I have successfully checked the latency with jack_iodelay in following way:
$ jack_iodelay  &

$ alsaloop -Pjackplug  -Cjackplug  &
$ jack_connect alsa-jack.jackP.998.0:out_000 jack_delay:in
$ jack_connect jack_delay:out alsa-jack.jackC.998.1:in_000
But total roundtrip latency, seems to be variable after each start-up.

Q1: What can be the root cause of this variable latency issue?
Q2: How can I find theoretical latency of the alsa-jack-plugin in both directions (playback - capture) ?

Thanks and Best Regards,
Valentin
Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052
