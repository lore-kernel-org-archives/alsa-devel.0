From: Patrick Boettcher <patrick.boettcher@desy.de>
Subject: Re: DigiDesign MBox USB Audio device
Date: Tue, 6 Apr 2004 00:12:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404052356490.20587@pub2.ifh.de>
References: <Pine.HPX.4.33n.0404051750110.25421-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="579715087-437318094-1081203145=:20587"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0404051750110.25421-100000@studcom.urz.uni-halle.de>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--579715087-437318094-1081203145=:20587
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Clemens,
On Mon, 5 Apr 2004, Clemens Ladisch wrote:
> Class 0xff means vendor-specific.  This is not a "USB Audio Device" as
> defined in the USB specifications.

Yes, I noticed it already, but I hoped that the vendor-specific part is
not so much vendor-specific, because they use a "normal" sound chip.

> What sample rate/format uses 304000 bytes per second?

I don't understand the question completely, what do you mean?

> Output of "lsusb -v"?

I attached a file filled with the output.

> > 2. Can I use somehow the i2c/cs8427.c?
> Probably not.  The CS8427 will be connected (via I2C) to some USB
> interface/controller chip.  Can you determine which one?

TAS1020A, Texas Instrument USB Streaming Controller. I thought I have to
talk to the sound chip directly and that the the usb chip is only
for bus control?! What can I do with knowing the usb control chip? Is this
the entry point for me?

> > 3. How does communication with the device should work?
>
> Sending/receiving sample data should work, but I guess this device
> needs vendor-specific commands to configure it.  These are control
> transfers, not isochronous; please look in the log file for them.

There are only isochronous transfers (of course, there are only
isoc-endpoints?) visible.

Beside of the a/d and d/a converter, there is only one bigger chip on the
device board. It is an EEPROM, I suppose to take the firmware, the owner
of the device told me, that sometimes he has to make a firmware update.

What exactly does the firmware? Is it the "other side" of the driver? If
so, I'm lost, am I?

Thanks for your answers, but as you can see, there are some more issues,
Patrick
--579715087-437318094-1081203145=:20587
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="lsusb.digi_mbox"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="lsusb.digi_mbox"

QnVzIDAwMiBEZXZpY2UgMDAzOiBJRCAwZGJhOjEwMDAgIA0KRGV2aWNlIERl
c2NyaXB0b3I6DQogIGJMZW5ndGggICAgICAgICAgICAgICAgMTgNCiAgYkRl
c2NyaXB0b3JUeXBlICAgICAgICAgMQ0KICBiY2RVU0IgICAgICAgICAgICAg
ICAxLjEwDQogIGJEZXZpY2VDbGFzcyAgICAgICAgICAgIDAgKERlZmluZWQg
YXQgSW50ZXJmYWNlIGxldmVsKQ0KICBiRGV2aWNlU3ViQ2xhc3MgICAgICAg
ICAwIA0KICBiRGV2aWNlUHJvdG9jb2wgICAgICAgICAwIA0KICBiTWF4UGFj
a2V0U2l6ZTAgICAgICAgICA4DQogIGlkVmVuZG9yICAgICAgICAgICAweDBk
YmEgDQogIGlkUHJvZHVjdCAgICAgICAgICAweDEwMDAgDQogIGJjZERldmlj
ZSAgICAgICAgICAgIDAuMjANCiAgaU1hbnVmYWN0dXJlciAgICAgICAgICAg
MSBEaWdpZGVzaWduIEluYw0KICBpUHJvZHVjdCAgICAgICAgICAgICAgICAy
IE1ib3ggVVNCIEF1ZGlvIERldmljZSBjb3B5cmlnaHQgRGlnaWRlc2lnbiAy
MDAxDQogIGlTZXJpYWwgICAgICAgICAgICAgICAgIDAgDQogIGJOdW1Db25m
aWd1cmF0aW9ucyAgICAgIDENCiAgQ29uZmlndXJhdGlvbiBEZXNjcmlwdG9y
Og0KICAgIGJMZW5ndGggICAgICAgICAgICAgICAgIDkNCiAgICBiRGVzY3Jp
cHRvclR5cGUgICAgICAgICAyDQogICAgd1RvdGFsTGVuZ3RoICAgICAgICAg
ICA1NA0KICAgIGJOdW1JbnRlcmZhY2VzICAgICAgICAgIDINCiAgICBiQ29u
ZmlndXJhdGlvblZhbHVlICAgICAxDQogICAgaUNvbmZpZ3VyYXRpb24gICAg
ICAgICAgMCANCiAgICBibUF0dHJpYnV0ZXMgICAgICAgICAweDgwDQogICAg
TWF4UG93ZXIgICAgICAgICAgICAgIDQ4MG1BDQogICAgSW50ZXJmYWNlIERl
c2NyaXB0b3I6DQogICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5DQog
ICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgICA0DQogICAgICBiSW50ZXJm
YWNlTnVtYmVyICAgICAgICAwDQogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAg
ICAgICAwDQogICAgICBiTnVtRW5kcG9pbnRzICAgICAgICAgICAwDQogICAg
ICBiSW50ZXJmYWNlQ2xhc3MgICAgICAgMjU1IFZlbmRvciBTcGVjaWZpYyBD
bGFzcw0KICAgICAgYkludGVyZmFjZVN1YkNsYXNzICAgICAgMCANCiAgICAg
IGJJbnRlcmZhY2VQcm90b2NvbCAgICAgIDAgDQogICAgICBpSW50ZXJmYWNl
ICAgICAgICAgICAgICAwIA0KICAgIEludGVyZmFjZSBEZXNjcmlwdG9yOg0K
ICAgICAgYkxlbmd0aCAgICAgICAgICAgICAgICAgOQ0KICAgICAgYkRlc2Ny
aXB0b3JUeXBlICAgICAgICAgNA0KICAgICAgYkludGVyZmFjZU51bWJlciAg
ICAgICAgMQ0KICAgICAgYkFsdGVybmF0ZVNldHRpbmcgICAgICAgMA0KICAg
ICAgYk51bUVuZHBvaW50cyAgICAgICAgICAgMA0KICAgICAgYkludGVyZmFj
ZUNsYXNzICAgICAgIDI1NSBWZW5kb3IgU3BlY2lmaWMgQ2xhc3MNCiAgICAg
IGJJbnRlcmZhY2VTdWJDbGFzcyAgICAgIDAgDQogICAgICBiSW50ZXJmYWNl
UHJvdG9jb2wgICAgICAwIA0KICAgICAgaUludGVyZmFjZSAgICAgICAgICAg
ICAgMCANCiAgICBJbnRlcmZhY2UgRGVzY3JpcHRvcjoNCiAgICAgIGJMZW5n
dGggICAgICAgICAgICAgICAgIDkNCiAgICAgIGJEZXNjcmlwdG9yVHlwZSAg
ICAgICAgIDQNCiAgICAgIGJJbnRlcmZhY2VOdW1iZXIgICAgICAgIDENCiAg
ICAgIGJBbHRlcm5hdGVTZXR0aW5nICAgICAgIDENCiAgICAgIGJOdW1FbmRw
b2ludHMgICAgICAgICAgIDINCiAgICAgIGJJbnRlcmZhY2VDbGFzcyAgICAg
ICAyNTUgVmVuZG9yIFNwZWNpZmljIENsYXNzDQogICAgICBiSW50ZXJmYWNl
U3ViQ2xhc3MgICAgICAwIA0KICAgICAgYkludGVyZmFjZVByb3RvY29sICAg
ICAgMCANCiAgICAgIGlJbnRlcmZhY2UgICAgICAgICAgICAgIDAgDQogICAg
ICBFbmRwb2ludCBEZXNjcmlwdG9yOg0KICAgICAgICBiTGVuZ3RoICAgICAg
ICAgICAgICAgICA5DQogICAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAg
IDUNCiAgICAgICAgYkVuZHBvaW50QWRkcmVzcyAgICAgMHg4MSAgRVAgMSBJ
Tg0KICAgICAgICBibUF0dHJpYnV0ZXMgICAgICAgICAgICA1DQogICAgICAg
ICAgVHJhbnNmZXIgVHlwZSAgICAgICAgICAgIElzb2Nocm9ub3VzDQogICAg
ICAgICAgU3luY2ggVHlwZSAgICAgICAgICAgICAgIEFzeW5jaHJvbm91cw0K
ICAgICAgICAgIFVzYWdlIFR5cGUgICAgICAgICAgICAgICBEYXRhDQogICAg
ICAgIHdNYXhQYWNrZXRTaXplICAgICAweDAxMzAgIGJ5dGVzIDMwNCBvbmNl
DQogICAgICAgIGJJbnRlcnZhbCAgICAgICAgICAgICAgIDENCiAgICAgICAg
YlJlZnJlc2ggICAgICAgICAgICAgICAgMA0KICAgICAgICBiU3luY2hBZGRy
ZXNzICAgICAgICAgICAwDQogICAgICBFbmRwb2ludCBEZXNjcmlwdG9yOg0K
ICAgICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5DQogICAgICAgIGJE
ZXNjcmlwdG9yVHlwZSAgICAgICAgIDUNCiAgICAgICAgYkVuZHBvaW50QWRk
cmVzcyAgICAgMHgwMiAgRVAgMiBPVVQNCiAgICAgICAgYm1BdHRyaWJ1dGVz
ICAgICAgICAgICAgNQ0KICAgICAgICAgIFRyYW5zZmVyIFR5cGUgICAgICAg
ICAgICBJc29jaHJvbm91cw0KICAgICAgICAgIFN5bmNoIFR5cGUgICAgICAg
ICAgICAgICBBc3luY2hyb25vdXMNCiAgICAgICAgICBVc2FnZSBUeXBlICAg
ICAgICAgICAgICAgRGF0YQ0KICAgICAgICB3TWF4UGFja2V0U2l6ZSAgICAg
MHgwMTMwICBieXRlcyAzMDQgb25jZQ0KICAgICAgICBiSW50ZXJ2YWwgICAg
ICAgICAgICAgICAxDQogICAgICAgIGJSZWZyZXNoICAgICAgICAgICAgICAg
IDANCiAgICAgICAgYlN5bmNoQWRkcmVzcyAgICAgICAgICAgMA0K

--579715087-437318094-1081203145=:20587--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
