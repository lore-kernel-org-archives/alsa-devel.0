From: Martin Langer <martin-langer@gmx.de>
Subject: Matrix XMLs (Tascam, RME, SEKD)
Date: Wed, 1 Dec 2004 20:59:26 +0100
Message-ID: <20041201195926.GA3771@tuba.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

I've fixed some XML files for the Soundcardmatrix. They're attached. 


martin

--OXfL5xGRrasGEqWY
Content-Type: text/xml; charset=us-ascii
Content-Disposition: attachment; filename="vendor-Tascam.xml"

<?xml version="1.0" encoding="US-ASCII"?>
<alsacards>
  <vendor>
    <name>Tascam</name>
    <link>http://www.tascam.com</link>
  </vendor>
  <device>
    <module>usb-usx2y</module>
    <product>
      <name>US-122</name>
      <link>http://www.tascam.com/Products/US-122.html</link>
    </product>
    <product>
      <name>US-224</name>
      <link>http://www.tascam.com/Products/US-224.html</link>
    </product>
    <product>
      <name>US-428</name>
      <link>http://www.tascam.com/Products/US-428.html</link>
    </product>
    <chip><name>EZUSB, FPGA</name></chip>
    <usb/>
  </device>
</alsacards>

--OXfL5xGRrasGEqWY
Content-Type: text/xml; charset=us-ascii
Content-Disposition: attachment; filename="vendor-RME.xml"

<?xml version="1.0" encoding="US-ASCII"?>
<alsacards>
  <vendor>
    <name>RME</name>
    <link>http://www.rme-audio.com</link>
  </vendor>
  <device>
    <module>rme32</module>
    <product>
      <name>Digi32</name>
      <link>http://www.rme-audio.com/english/digi32/digi32.htm</link>
    </product>
    <product>
      <name>Digi32Pro</name>
      <link>http://www.rme-audio.com/english/digi32/digi32pr.htm</link>
    </product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in count="1"/>
    <has_spdif_out count="1"/>
    <has_toslink_in count="1"/>
    <has_toslink_out count="1"/>
    <pci_bus/>
  </device>
  <device>
    <module>rme32</module>
    <product>
      <name>Digi32/8</name>
      <link>http://www.rme-audio.com/english/digi32/digi328.htm</link>
    </product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in count="1"/>
    <has_spdif_out count="1"/>
    <has_toslink_in count="1"/>
    <has_toslink_out count="1"/>
    <has_adat_in count="1"/>
    <has_adat_out count="1"/>
    <pci_bus/>
  </device>
  <device>
    <module>rme9652</module>
    <product>
      <name>Hammerfall</name>
      <link>http://www.rme-audio.com/english/hammer/d9652.htm</link>
    </product>
    <product>
      <name>Hammerfall Light</name>
      <link>http://www.rme-audio.com/english/hammer/d9636.htm</link>
    </product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in count="1"/>
    <has_spdif_out count="1"/>
    <has_toslink_in count="1"/>
    <has_toslink_out count="1"/>
    <has_adat_in count="1"/>
    <has_adat_out count="1"/>
    <pci_bus/>
  </device>
  <device>
    <module>hdsp</module>
    <product>
      <name>Hammerfall DSP Digiface</name>
      <link>http://www.rme-audio.com/english/hdsp/cardpci.htm</link>
    </product>
    <product>
      <name>Hammerfall DSP Multiface</name>
      <link>http://www.rme-audio.com/english/hdsp/cardpci.htm</link>
    </product>
    <product>
      <name>Hammerfall DSP 9632</name>
      <link>http://www.rme-audio.com/english/hdsp/hdsp9632.htm</link>
    </product>
    <product>
      <name>Hammerfall DSP 9652</name>
      <link>http://www.rme-audio.com/english/hdsp/hdsp9652.htm</link>
    </product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in count="1"/>
    <has_spdif_out count="1"/>
    <has_toslink_in count="1"/>
    <has_toslink_out count="1"/>
    <has_adat_in count="1"/>
    <has_adat_out count="1"/>
    <pci_bus/>
  </device>
  <device>
    <module>hdspm</module>
    <product>
      <name>Hammerfall DSP Madi</name>
      <link>http://www.rme-audio.com/english/hdsp/hdspmadi.htm</link>
    </product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in count="1"/>
    <has_spdif_out count="1"/>
    <has_toslink_in count="1"/>
    <has_toslink_out count="1"/>
    <has_adat_in count="1"/>
    <has_adat_out count="1"/>
    <pci_bus/>
  </device>
  <device>
    <module>rme96</module>
    <product>
      <name>Digi96</name>
      <link>http://www.rme-audio.com/english/digi96/digi96.htm</link>
    </product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in count="1"/>
    <has_spdif_out count="1"/>
    <has_toslink_in count="1"/>
    <has_toslink_out count="1"/>
    <pci_bus/>
  </device>
  <device>
    <module>rme96</module>
    <product>
      <name>Digi96/8</name>
      <link>http://www.rme-audio.com/english/digi96/digi968.htm</link>
    </product>
    <product>
      <name>Digi96/8 PRO</name>
      <link>http://www.rme-audio.com/english/digi96/digi96pr.htm</link>
    </product>
    <product>
      <name>Digi96/8 PST</name>
      <link>http://www.rme-audio.com/english/digi96/digi96ps.htm</link>
    </product>
    <product>
      <name>Digi96/8 PAD</name>
      <link>http://www.rme-audio.com/english/digi96/digi96ps.htm</link>
    </product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in count="1"/>
    <has_spdif_out count="1"/>
    <has_toslink_in count="1"/>
    <has_toslink_out count="1"/>
    <has_adat_in count="1"/>
    <has_adat_out count="1"/>
    <pci_bus/>
  </device>
  <device>
    <product>
      <name>Fireface 800</name>
      <link>http://www.rme-audio.com/english/firewire/ff800.htm</link>
    </product>
    <has_spdif_in count="1"/>
    <has_spdif_out count="1"/>
    <has_toslink_in count="1"/>
    <has_toslink_out count="1"/>
    <has_adat_in count="1"/>
    <has_adat_out count="1"/>
    <unsupported/>
  </device>
</alsacards>


--OXfL5xGRrasGEqWY
Content-Type: text/xml; charset=us-ascii
Content-Disposition: attachment; filename="vendor-SEKD.xml"

<?xml version="1.0" encoding="US-ASCII"?>
<alsacards>
  <vendor>
    <name>SEK'D</name>
    <link>http://www.sekd.com</link>
  </vendor>
  <device>
    <module>rme32</module>
    <product><name>Prodif 32</name></product>
    <product><name>Prodif 96</name></product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in/>
    <has_spdif_out/>
    <has_toslink_in/>
    <has_toslink_out/>
    <extrainfo>driver untested</extrainfo>
    <pci/>
  </device>
  <device>
    <module>rme32</module>
    <product><name>Prodif Gold</name></product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in/>
    <has_spdif_out/>
    <has_toslink_in/>
    <has_toslink_out/>
    <has_adat_in/>
    <has_adat_out/>
    <extrainfo>driver untested</extrainfo>
    <pci/>
  </device>
  <device>
    <module>pdplus</module>
    <product><name>Prodif Plus</name></product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in/>
    <has_spdif_out/>
    <has_toslink_in/>
    <has_toslink_out/>
    <has_adat_in/>
    <has_adat_out/>
    <pci/>
  </device>
  <device>
    <undetermined/>
    <product><name>ARC 44</name></product>
    <chip><name>FPGA</name></chip>
    <pci/>
  </device>
  <device>
    <possible/>
    <product><name>ARC 88</name></product>
    <chip><name>FPGA</name></chip>
    <has_toslink_in/>
    <has_toslink_out/>
    <pci/>
  </device>
  <device>
    <possible/>
    <product>
      <name>Prodif24</name>
    </product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in/>
    <has_spdif_out/>
    <has_toslink_in/>
    <has_toslink_out/>
    <pci/>
  </device>
  <device>
    <possible/>
    <product>
      <name>Prodif96 Pro</name>
    </product>
    <chip><name>FPGA</name></chip>
    <has_spdif_in/>
    <has_spdif_out/>
    <has_toslink_in/>
    <has_toslink_out/>
    <pci/>
  </device>
  <device>
    <possible/>
    <product>
      <name>Siena</name>
    </product>
    <pci/>
  </device>
</alsacards>

--OXfL5xGRrasGEqWY--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
