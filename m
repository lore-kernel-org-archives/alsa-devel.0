From: "Merx, Thomas" <thomas.merx@intel.com>
Subject: [alsa-jack-plugin] Feedback to modification proposal
Date: Fri, 7 Sep 2012 13:00:59 +0000
Message-ID: <D2B94D961C99E941B2B362FCFFEC367119BD3249@IRSMSX103.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 3259D2616D6
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 15:01:07 +0200 (CEST)
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

Hello all,

I would like to get some feedback here from you experts on the alsa-jack-plugin. In my project there is a jack-plugin that provides several jack input ports were different streams from different source applications shall be connectable. The source applications would provide the audio samples to jack via the alsa-jack-plugin. On top of that there is a control layer that has to connect the jack output ports of the alsa-jack-plugin with the input ports of my jack-plugin. The API of the control layer simply uses an ID for the source and an ID for the sink to know which jack output ports have to be connected to which input ports. The challenge I'm now facing is that the full name of the jack ports registered by the alsa-jack-plugin are changing from startup to startup because they include the p
 rocess id of the playback application. Considering the case that there could be two instances of the same application and each of them providing a playback stream via the alsa-jack-plugin, it is cha
 llenging for the control layer to choose the correct stream for connecting it to my jack-plugin. So my main problem is that I cannot associate the IDs used for the control layer with the jack port names automatically created by the alsa-jack-plugin.
A possible solution to my problem could be to add an additional entry in the asound.conf section where the jack plugin is defined to provide a name which shall be chosen as a prefix for the full jack port name, instead of the default naming scheme currently chosen. To have it backward compatible it could be implemented in a way that if the entry in the asound.conf is missing the current naming scheme is chosen and only if the new entry is set it will be used for the name to be registered at the jack server. What do you think about that? Does it make sense to have that functionality? 

Best regards
Thomas
Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Peter Gleissner, Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052
