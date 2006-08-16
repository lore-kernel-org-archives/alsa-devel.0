From: "Andrew L. Neporada" <nepal@asplinux.ru>
Subject: Re: Connexant HDA codec support
Date: Wed, 16 Aug 2006 17:44:12 +0400
Message-ID: <1155735852.3871.51.camel@leeloo.asplinux.ru>
References: <1155721544.3871.43.camel@leeloo.asplinux.ru>
	<s5hac64ygw0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-n3/Oc+VRaXEcphpAWJgK"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hac64ygw0.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-n3/Oc+VRaXEcphpAWJgK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Takashi Iwai wrote:
> Good to hear that playback actually works on some machine.
> How is the mixer status?  Check the generated file via "alsactl -f
> somefile store".
> 
alsactl output attached

> The problem looks like that the input amp value isn't raised for the
> audio-input node 0x1a.  Could be a bug of generic parser routine.
> 

How can I help to investigate this issue?

> 
> Takashi
> 

Andrew


--=-n3/Oc+VRaXEcphpAWJgK
Content-Disposition: attachment; filename=alsactl
Content-Type: text/plain; name=alsactl; charset=utf-8
Content-Transfer-Encoding: 7bit

state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 23'
		iface MIXER
		name 'Capture Volume'
		value.0 23
		value.1 23
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 43'
		iface MIXER
		name 'Master Playback Volume'
		value.0 0
		value.1 0
	}
}

--=-n3/Oc+VRaXEcphpAWJgK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-n3/Oc+VRaXEcphpAWJgK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-n3/Oc+VRaXEcphpAWJgK--
