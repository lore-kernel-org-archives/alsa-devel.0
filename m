From: Giuliano Pochini <pochini@shiny.it>
Subject: Soundcard matrix update
Date: Sat, 17 Jan 2004 19:44:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040117194418.4b839018.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__17_Jan_2004_19_44_18_+0100_kwhq/TXIRdD4tJ+P"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Sat__17_Jan_2004_19_44_18_+0100_kwhq/TXIRdD4tJ+P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Attached is an update to the current status of the driver for Echoaudio
cards. That page is now generated dynamically and I don't know what
format do you prefer. I just grabbed the page and edited it.


--
Giuliano.


--Multipart=_Sat__17_Jan_2004_19_44_18_+0100_kwhq/TXIRdD4tJ+P
Content-Type: text/html;
 name="echoindex.html"
Content-Disposition: attachment;
 filename="echoindex.html"
Content-Transfer-Encoding: 7bit


<!-- Head start -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>
      Advanced Linux Sound Architecture - Soundcard Matrix
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	  <link rel="SHORTCUT ICON" href="/pictures/alsa.ico">
    <style type="text/css">
       <!--
          A:link {text-decoration: none}
          A:visited {text-decoration: none}
          A:active {text-decoration: none}
       -->
    </style>
  </head>
  <body bgcolor="#ffffff" text="#000000" link="#0000ff" alink="#0000ff" vlink="#0000ff">
<!-- Head end -->
<p align=center><img src="/pictures/title.jpg"></p>
<p align=center>[<a href="/">main page</a>] | [<a href="/alsa-doc">soundcards</a>] | [<a href="/documentation.php3">documentation</a>] | [<a href="/applications.php3">applications</a>] | [<a href="/download.php3">download</a>] | [<a href="/mailing-lists.php3">mailing lists</a>] | [<a href="/links.php3">links</a>] | [<a href="http://sourceforge.net/projects/alsa">SourceForge</a>]</p>
<hr noshade width="100%">



<center>
<h1><font color="#447f57">ALSA Soundcard Matrix</font></h1>
</center>

<table width="100%">
<tr>
<td align="center">

	<table width="600">
	<tr>
	<td align="left">

	<b>NB.</b> Even if we have vendor supplied driver documents they may refuse to provide all the necessary information to support devices fully.<p>

Corrections should be sent to the <a href="mailto:alsa-devel@lists.sourceforge.net">alsa-devel</a> mailing list. <p>

	- You can see a list of the known bugs <a href="doc-php/bugs-full.php3">here</a>.<br>
	- You can view an indexed page of all the user notes <a href="doc-php/notes-full.php3">here</a>.<br>
	- Generic instructions on using the <a href="doc-php/asoundrc.php3?company=Generic&card=Generic&chip=Generic&module=Generic">.asoundrc</a> file effectively<br>
	- Read about how the online docs work <a href="README.php3">here</a><p>


 	Cards or chipsets marked:<p>
	
		<table width="600">
		<tr>
		<td align="left" valign="top" width="200" >

		- [X-], hilighted <font color="#ff0000">RED</font>:
		</td>
		<td align="left">
		Unsupported because the vendor refuses to release programming information.
		</td></tr>
		<tr><td align="left" valign="top" width="200">

		- [X?], hilighted <font color="#aaaaaa">GREY</font>:		
		</td>
		<td align="left">
		Support is undetermined as of yet.
		
		</td></tr>
		<tr><td align="left" valign="top" width="200">
		
		- [X+], hilighted <font color="#00ff00">GREEN</font>:
		</td>
		<td align="left">
		Possible to support, but no driver has been written yet.

		</td>
		</tr>
		</table>
		
		
	<p>All USB devices that are standards compliant will work. If they do not please report to the mailing lists. If your USB device is not on this list yet here are some generic install instructions.&nbsp;&nbsp; <a href="doc-php/template.php?company=USB&card=Generic&chip=Generic&module=usb-audio">usb-audio</a>
	 </td>
	</tr>
	</table>

</td>
</tr>
</table>

<div style="position:relative; top:40; left:120; z-index:1" align="left"> 
	<a name="matrix">&nbsp;</a>
	<a href="index.php#alsa-top\">Top</a>
</div>

<div style="position:relative; top:0; left:0; z-index:1"> 
<table border="0" width="100%">
 <tr>
    <td align="center">
  
  <a name="matrix">Choose manufacturer for more details</a>
  <FORM Action="/alsa-doc/index.php3#matrix">
	<SELECT NAME="vendor" SIZE="1">
		<OPTION value="All">All
		<OPTION disabled >---------------------------
		<OPTION value="vendor-AudioExcel">AudioExcel
		<OPTION value="vendor-A-trend">Atrend
		<OPTION value="vendor-ALi">ALi
		<OPTION value="vendor-AMD">AMD
		<OPTION value="vendor-ASOUND">ASOUND
		<OPTION value="vendor-Abit">Abit
		<OPTION value="vendor-Alesis">Alesis
		<OPTION value="vendor-Aopen">Aopen
		<OPTION value="vendor-Analog_Devices">Analog&nbsp;Devices
		<OPTION value="vendor-Chic_Technology">Chic&nbsp;Technology
		<OPTION value="vendor-AudioScience">AudioScience
		<OPTION value="vendor-AudioTrak">AudioTrak
		<OPTION value="vendor-Aureal">Aureal
		<OPTION value="vendor-Avance_Logic">Avance&nbsp;Logic
		<OPTION value="vendor-AzTech">AzTech
		<OPTION value="vendor-Best_Union">Best&nbsp;Union
		<OPTION value="vendor-Brooktree">Brooktree
		<OPTION value="vendor-C-Media">CMedia
		<OPTION value="vendor-ESS_Technology">ESS&nbsp;Technology
		<OPTION value="vendor-Cirrus_Logic">Cirrus&nbsp;Logic
		<OPTION value="vendor-Compustar">Compustar
		<OPTION value="vendor-Core_Sound">Core&nbsp;Sound
		<OPTION value="vendor-Creative_Labs">Creative&nbsp;Labs
		<OPTION value="vendor-Digigram">Digigram
		<OPTION value="vendor-Diamond_Multimedia">Diamond&nbsp;Multimedia
		<OPTION value="vendor-Dynasonic">Dynasonic
		<OPTION value="vendor-Digital_Audio_Labs">Digital&nbsp;Audio&nbsp;Labs
		<OPTION value="vendor-Mark_Of_The_Unicorn">Mark&nbsp;Of&nbsp;The&nbsp;Unicorn
		<OPTION value="vendor-Echo_Corporation">Echo&nbsp;Corporation
		<OPTION value="vendor-Ego_Sys">Ego&nbsp;Sys
		<OPTION value="vendor-Ensoniq">Ensoniq
		<OPTION value="vendor-Evolution">Evolution
		<OPTION value="vendor-Fortemedia">Fortemedia
		<OPTION value="vendor-Frontier_Design">Frontier&nbsp;Design
		<OPTION value="vendor-Gadget_Labs">Gadget&nbsp;Labs
		<OPTION value="vendor-Genius">Genius
		<OPTION value="vendor-Gravis">Gravis
		<OPTION value="vendor-Guillemot">Guillemot
		<OPTION value="vendor-HIS">HIS
		<OPTION value="vendor-Hercules">Hercules
		<OPTION value="vendor-Hoontech">Hoontech
		<OPTION value="vendor-IC_Ensemble">IC&nbsp;Ensemble
		<OPTION value="vendor-Intel">Intel
		<OPTION value="vendor-Jaton">Jaton
		<OPTION value="vendor-Labway">Labway
		<OPTION value="vendor-Lexicon">Lexicon
		<OPTION value="vendor-MAudio">MAudio
		<OPTION value="vendor-NEC">NEC
		<OPTION value="vendor-Lynx_Studio_Technology">Lynx&nbsp;Studio&nbsp;Technology
		<OPTION value="vendor-Roland_Edirol">Roland&nbsp;Edirol
		<OPTION value="vendor-Neomagic">Neomagic
		<OPTION value="vendor-Nvidia">Nvidia
		<OPTION value="vendor-Opcode">Opcode
		<OPTION value="vendor-Oak_Technology">Oak&nbsp;Technology
		<OPTION value="vendor-Opti">Opti
		<OPTION value="vendor-PINE">PINE
		<OPTION value="vendor-Phillips">Phillips
		<OPTION value="vendor-RME">RME
		<OPTION value="vendor-Seasound">Seasound
		<OPTION value="vendor-SEKD">SEKD
		<OPTION value="vendor-STB">STB
		<OPTION value="vendor-Shuttle">Shuttle
		<OPTION value="vendor-Sega">Sega
		<OPTION value="vendor-Shark_Multimedia">Shark&nbsp;Multimedia
		<OPTION value="vendor-SiS">SiS
		<OPTION value="vendor-Sonorus">Sonorus
		<OPTION value="vendor-Sony">Sony
		<OPTION value="vendor-Steinberg">Steinberg
		<OPTION value="vendor-Stereo-Link">StereoLink
		<OPTION value="vendor-Tascam">Tascam
		<OPTION value="vendor-Terratec">Terratec
		<OPTION value="vendor-Toshiba">Toshiba
		<OPTION value="vendor-Trident">Trident
		<OPTION value="vendor-Trust">Trust
		<OPTION value="vendor-Turtle_Beach">Turtle&nbsp;Beach
		<OPTION value="vendor-VIA">VIA
		<OPTION value="vendor-VLSI">VLSI
		<OPTION value="vendor-VideoLogic">VideoLogic
		<OPTION value="vendor-Xitel">Xitel
		<OPTION value="vendor-Yamaha">Yamaha
		<OPTION value="vendor-Zefiro">Zefiro
		<OPTION value="vendor-Zoltrix">Zoltrix
		<OPTION value="vendor-s3">s3
	</SELECT>
	<input TYPE="submit" VALUE="Go">
  </form>

Last update Monday 15 December 2003 11:08
</td>
</tr>
</table>

<table border="1" width="100%">
 <tbody>
  <tr>
   <th>Vendor</th>
   <th>Product</th>
   <th>Chipset(s)</th>
   <th>Driver & Docs</th>
   <th>Notes</th>
  </tr>
  
  <tr>
   <td rowspan="8" align="center"><b><a href="http://www.echoaudio.com/">Echo Corporation</a></b></td>
   <td>Darla</td>
   <td>Motorola 56301</td>
   <td align="center"><a href="http://xoomer.virgilio.it/g_pochini/ea.html">Details</a></td>
   <td>*</td>
  </tr>

  <tr>
   <td>Gina</td>
   <td>Motorola 56301</td>
   <td align="center"><a href="http://xoomer.virgilio.it/g_pochini/ea.html">Details</a></td>
   <td>[Rio]*</td>
  </tr>

  <tr>
   <td>Layla</td>
   <td>Motorola 56301</td>
   <td align="center"><a href="http://xoomer.virgilio.it/g_pochini/ea.html">Details</a></td>
   <td>[Rio]*</td>
  </tr>

  <tr>
   <td>Darla24</td>
   <td>Motorola 56301</td>
   <td align="center"><a href="http://xoomer.virgilio.it/g_pochini/ea.html">Details</a></td>
   <td>*</td>
  </tr>

  <tr>
   <td><a href="http://www.echoaudio.com/Products/Gina24/index.php">Gina24</a></td>
   <td>Motorola 56301 or 56361</td>
   <td align="center"><a href="http://xoomer.virgilio.it/g_pochini/ea.html">Details</a></td>
   <td>[Rio][Tio][Aio]*</td>
  </tr>

  <tr>
   <td><a href="http://www.echoaudio.com/Products/Layla24/index.php">Layla24</a></td>
   <td>Motorola 56361</td>
   <td align="center"><a href="http://xoomer.virgilio.it/g_pochini/ea.html">Details</a></td>
   <td>[Rio][Tio][Aio]*</td>
  </tr>

  <tr>
   <td><a href="http://www.echoaudio.com/Products/Mona/index.php">Mona</a></td>
   <td>Motorola 56361</td>
   <td align="center"><a href="http://xoomer.virgilio.it/g_pochini/ea.html">Details</a></td>
   <td>[Rio][Tio][Aio]*</td>
  </tr>

  <tr>
   <td><a href="http://www.echoaudio.com/Products/MiaMIDI/index.php">Mia / Mia-midi</a></td>
   <td>Motorola 56361</td>
   <td align="center"><a href="http://xoomer.virgilio.it/g_pochini/ea.html">Details</a></td>
   <td>[Rio]*(4)</td>
  </tr>
 </tbody>
</table>

<table border="0" width="100%">
    <tr>
    <td>
 <h2>Key</h2>
 <b>NOTE:</b> <i>Just because an I/O is listed does NOT mean it is guaranteed 
to be supported. Please check the mailing list archives before making purchase 
decisions based on requirements for IEC-60958 or ADAT I/O.</i><br>
 <br>
 [Ri]  IEC-60958 RCA Input<br>
 [Ro]  IEC-60958 RCA Output<br>
 [Rio] both<br>
 [Ti]  IEC-60958 TOSLINK Input<br>
 [To]  IEC-60958 TOSLINK Output<br>
 [Tio] both<br>
 [Ai]  ADAT Input<br>
 [Ao]  ADAT Output<br>
 [Aio] both<br>
 [X?]  Support undetermined.<br>
 [X+]  Possible to support, but no driver has been written yet<br>
 [X-]  Unsupported because the vendor refuses to release programming
	 information.<br>
 <p>
 (*) Driver not yet in CVS<br>
 (1) Output always resampled to 48khz.<br>
 (2) Output at 44khz only, output sometimes erroneously inverted.<br>
 (3) CSP Chip supported<br>
 (4) Hardware mixing supported<br>
 (5) Hardware doesn't do 24 bits via USB.
     Hardware doesn't do 96 kHz via USB.<br>
</td>
</tr>
</table>

 <!-- Tail copyright start -->
<hr noshade width="100%">
<table border=0 width="100%">
  <tr>
    <td>
      <font size=2>
        Copyright &copy; 2004 by <!-- Email prepare start --><script language="JavaScript">
_x_x_y_y_user="webmaster"
_x_x_y_y_domain="alsa-project.org"
document.write('<a href=\"mailto:' + _x_x_y_y_user + '@' + _x_x_y_y_domain + '\">' + "ALSA webmaster" + '</a>');
</script><!-- Email prepare end -->
      </font>
    </td>
    <td align="right">
        <font size=2>
          <font color="red">A</font>dvanced
          <font color="red">L</font>inux
          <font color="red">S</font>ound
          <font color="red">A</font>rchitecture
        </font>
    </td>
  </tr>
</table>
<!-- Tail copyright end -->

</div>


--Multipart=_Sat__17_Jan_2004_19_44_18_+0100_kwhq/TXIRdD4tJ+P--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
