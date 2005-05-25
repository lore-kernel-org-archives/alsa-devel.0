From: Giuliano Pochini <pochini@shiny.it>
Subject: echoaudio - soundcards matrix update
Date: Wed, 25 May 2005 22:02:40 +0200
Message-ID: <20050525220240.397fa953.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__25_May_2005_22_02_40_+0200_.t3i0VhSPZ9ZNZ5J"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Wed__25_May_2005_22_02_40_+0200_.t3i0VhSPZ9ZNZ5J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Attached is an update for the echoaudio driver.

<not_in_cvs> allowed me to put a link to the page that hosted the driver
when it wasn't in alsa-driver yet, which has a lot of info that users may
find useful. Is there another way to publish such a link ?


--
Giuliano.



--Multipart=_Wed__25_May_2005_22_02_40_+0200_.t3i0VhSPZ9ZNZ5J
Content-Type: text/xml;
 name="vendor-Echoaudio.xml"
Content-Disposition: attachment;
 filename="vendor-Echoaudio.xml"
Content-Transfer-Encoding: 7bit

<?xml version="1.0" encoding="US-ASCII"?>
<alsacards>
  <vendor>
    <name>Echo Digital Audio Corporation</name>
    <link>http://www.echoaudio.com</link>
  </vendor>

  <device>
    <module>darla20</module>
    <product>
      <name>Darla</name>
    </product>
    <chip>
      <name>Motorola 56301</name>
    </chip>
    <pci_bus/>
    <has_analog_out count="8"/>
    <has_analog_in count="2"/>
    <extrainfo>Discontinued</extrainfo>
  </device>

  <device>
    <module>gina20</module>
    <product>
      <name>Gina</name>
    </product>
    <chip>
      <name>Motorola 56301</name>
    </chip>
    <pci_bus/>
    <has_analog_out count="8"/>
    <has_analog_in count="2"/>
    <has_spdif_out count="1"/>
    <has_spdif_in count="1"/>
    <extrainfo>Discontinued</extrainfo>
  </device>

  <device>
    <module>layla20</module>
    <product>
      <name>Layla</name>
    </product>
    <chip>
      <name>Motorola 56301, FPGA</name>
    </chip>
    <pci_bus/>
    <has_analog_out count="10"/>
    <has_analog_in count="8"/>
    <has_spdif_out count="1"/>
    <has_spdif_in count="1"/>
    <has_midi_out count="1"/>
    <has_midi_in count="1"/>
    <extrainfo>Discontinued</extrainfo>
  </device>

  <device category="pro">
    <module>darla24</module>
    <product>
      <name>Darla24</name>
    </product>
    <chip>
      <name>Motorola 56301</name>
    </chip>
    <pci_bus/>
    <has_analog_out count="8"/>
    <has_analog_in count="2"/>
    <extrainfo>Discontinued</extrainfo>
  </device>

  <device category="pro">
    <module>gina24</module>
    <product>
      <name>Gina24</name>
      <link>http://www.echoaudio.com/Products/Discontinued/Gina24/index.php</link>
    </product>
    <chip>
      <name>Motorola 56301 or 56361, FPGA</name>
    </chip>
    <pci_bus/>
    <has_analog_out count="8"/>
    <has_analog_in count="2"/>
    <has_spdif_out count="1"/>
    <has_spdif_in count="1"/>
    <has_toslink_out count="1"/>
    <has_toslink_in count="1"/>
    <has_adat_out count="1"/>
    <has_adat_in count="1"/>
    <extrainfo>Discontinued</extrainfo>
  </device>

  <device category="pro">
    <module>layla24</module>
    <product>
      <name>Layla24</name>
      <link>http://www.echoaudio.com/Products/Discontinued/Layla24/index.php</link>
    </product>
    <product>
      <name>Layla24-CARDBUS</name>
      <link>http://www.echoaudio.com/Products/CardBus/Laptop/index.php</link>
    </product>
    <chip>
      <name>Motorola 56361, FPGA</name>
    </chip>
    <pci_bus/>
    <pcmcia/>
    <has_analog_out count="8"/>
    <has_analog_in count="8"/>
    <has_spdif_out count="1"/>
    <has_spdif_in count="1"/>
    <has_toslink_out count="1"/>
    <has_toslink_in count="1"/>
    <has_adat_out count="1"/>
    <has_adat_in count="1"/>
    <has_midi_out count="1"/>
    <has_midi_in count="1"/>
    <extrainfo>Discontinued</extrainfo>
  </device>

  <device category="pro">
    <module>mona</module>
    <product>
      <name>Mona</name>
      <link>http://www.echoaudio.com/Products/Discontinued/Mona/index.php</link>
    </product>
    <product>
      <name>Mona-CARDBUS</name>
      <link>http://www.echoaudio.com/Products/CardBus/Laptop/index.php</link>
    </product>
    <chip>
      <name>Motorola 56301 or 56361, FPGA</name>
    </chip>
    <pci_bus/>
    <pcmcia/>
    <has_analog_out count="6"/>
    <has_analog_in count="4"/>
    <has_spdif_out count="1"/>
    <has_spdif_in count="1"/>
    <has_toslink_out count="1"/>
    <has_toslink_in count="1"/>
    <has_adat_out count="1"/>
    <has_adat_in count="1"/>
    <extrainfo>Discontinued</extrainfo>
  </device>

  <device category="pro">
    <module>mia</module>
    <product>
      <name>Mia</name>
      <link>http://www.echoaudio.com/Products/Discontinued/Mia/index.php</link>
    </product>
    <chip>
      <name>Motorola 56361</name>
    </chip>
    <pci_bus/>
    <has_analog_out count="2"/>
    <has_analog_in count="2"/>
    <has_spdif_out count="1"/>
    <has_spdif_in count="1"/>
    <has_mixing/>
    <extrainfo>Discontinued</extrainfo>
  </device>

  <device category="pro">
    <module>mia</module>
    <product>
      <name>Mia-midi</name>
      <link>http://www.echoaudio.com/Products/PCI/MiaMIDI/index.php</link>
    </product>
    <chip>
      <name>Motorola 56361</name>
    </chip>
    <pci_bus/>
    <has_analog_out count="2"/>
    <has_analog_in count="2"/>
    <has_spdif_out count="1"/>
    <has_spdif_in count="1"/>
    <has_midi_out count="1"/>
    <has_midi_in count="1"/>
    <has_mixing/>
  </device>

  <device category="pro">
    <module>indigo</module>
    <product>
      <name>Indigo</name>
      <link>http://www.echoaudio.com/Products/Discontinued/Indigo/index.php</link>
    </product>
    <chip>
      <name>Motorola 56361</name>
    </chip>
    <pcmcia/>
    <has_analog_out count="2"/>
    <has_mixing/>
    <extrainfo>Discontinued</extrainfo>
  </device>

  <device category="pro">
    <module>indigoio</module>
    <product>
      <name>Indigo IO</name>
      <link>http://www.echoaudio.com/Products/CardBus/IndigoIO/index.php</link>
    </product>
    <chip>
      <name>Motorola 56361</name>
      <link></link>
    </chip>
    <pcmcia/>
    <has_analog_out count="2"/>
    <has_analog_in count="2"/>
    <has_mixing/>
  </device>

  <device category="pro">
    <module>indigodj</module>
    <product>
      <name>Indigo DJ</name>
      <link>http://www.echoaudio.com/Products/CardBus/IndigoDJ/index.php</link>
    </product>
    <chip>
      <name>Motorola 56361</name>
    </chip>
    <pcmcia/>
    <has_analog_out count="4"/>
    <has_mixing/>
  </device>

  <device category="pro">
    <module>echo3g</module>
    <product>
      <name>Gina 3G</name>
      <link>http://www.echoaudio.com/Products/PCI/Gina3G/index.php</link>
    </product>
    <chip>
      <name>Motorola 56361, FPGA</name>
    </chip>
    <pci_bus/>
    <has_analog_out count="6"/>
    <has_analog_in count="2"/>
    <has_spdif_out count="1"/>
    <has_spdif_in count="1"/>
    <has_toslink_out count="1"/>
    <has_toslink_in count="1"/>
    <has_adat_out count="1"/>
    <has_adat_in count="1"/>
    <has_midi_out count="1"/>
    <has_midi_in count="1"/>
  </device>

  <device category="pro">
    <module>echo3g</module>
    <product>
      <name>Layla 3G</name>
      <link>http://www.echoaudio.com/Products/PCI/Layla3G/index.php</link>
    </product>
    <chip>
      <name>Motorola 56361, FPGA</name>
    </chip>
    <pci_bus/>
    <has_analog_out count="8"/>
    <has_analog_in count="8"/>
    <has_spdif_out count="1"/>
    <has_spdif_in count="1"/>
    <has_toslink_out count="1"/>
    <has_toslink_in count="1"/>
    <has_adat_out count="1"/>
    <has_adat_in count="1"/>
    <has_midi_out count="1"/>
    <has_midi_in count="1"/>
  </device>

</alsacards>



--Multipart=_Wed__25_May_2005_22_02_40_+0200_.t3i0VhSPZ9ZNZ5J--


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
