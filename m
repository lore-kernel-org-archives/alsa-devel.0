From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: External sound card issue
Date: Mon, 20 Jan 2014 21:01:23 +0800
Message-ID: <CAN8cciYR_9Le-tX-CLBjfnYQ1+CuexKzxpxberVkkV6jR_c50A@mail.gmail.com>
References: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>
 <52DD1A66.9050909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com
 [209.85.223.178])
 by alsa0.perex.cz (Postfix) with ESMTP id E52422615FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 14:01:24 +0100 (CET)
Received: by mail-ie0-f178.google.com with SMTP id x13so8031259ief.23
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 05:01:24 -0800 (PST)
In-Reply-To: <52DD1A66.9050909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Ionica Bizau <bizauionica@gmail.com>
List-Id: alsa-devel@alsa-project.org

2014/1/20 Clemens Ladisch <clemens@ladisch.de>

> Ionica Bizau wrote:
> > I have just bought an external sound card: Asus Xonar U7
> >
> >     cannot load mixer controls: Broken pipe
>
> This looks like a bug in the device's firmware.
>
> Can you at least read the list of controls ("amixer -c1 controls")?
> Are there some controls that you are able to access (try
> "amixer -c1 cget name='xxx'" for each one)?
>
>
alsactl store -f abc.txt
alsactl: get_control:256: Cannot read control '2,0,0,PCM Capture Source,0':
Broken

[ 398.119996] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex =
0x1400, type = 3

seem fail to read the capture source control


state.Device {
 control.1 {
  iface PCM
  name 'Playback Channel Map'
  value.0 0
  value.1 0
  comment {
   access read
   type INTEGER
   count 2
   range '0 - 36'
  }
 }
 control.2 {
  iface PCM
  device 1
  name 'Playback Channel Map'
  value.0 0
  value.1 0
  comment {
   access read
   type INTEGER
   count 2
   range '0 - 36'
  }
 }
 control.3 {
  iface MIXER
  name 'PCM Playback Switch'
  value true
  comment {
   access 'read write'
   type BOOLEAN
   count 1
  }
 }
 control.4 {
  iface MIXER
  name 'PCM Playback Switch'
  index 1
  value true
  comment {
   access 'read write'
   type BOOLEAN
   count 1
  }
 }
 control.5 {
  iface MIXER
  name 'PCM Playback Volume'
  value.0 107
  value.1 107
  value.2 107
  value.3 107
  value.4 107
  value.5 107
  value.6 107
  value.7 107
  comment {
   access 'read write'
   type INTEGER
   count 8
   range '0 - 127'
   dbmin -12700
   dbmax 0
   dbvalue.0 -2000
   dbvalue.1 -2000
   dbvalue.2 -2000
   dbvalue.3 -2000
   dbvalue.4 -2000
   dbvalue.5 -2000
   dbvalue.6 -2000
   dbvalue.7 -2000
  }
 }
 control.6 {
  iface MIXER
  name 'Mic Capture Switch'
  value true
  comment {
   access 'read write'
   type BOOLEAN
   count 1
  }
 }
 control.7 {
  iface MIXER
  name 'Line Capture Switch'
  value true
  comment {
   access 'read write'
   type BOOLEAN
   count 1
  }
 }
 control.8 {
  iface MIXER
  name 'PCM Capture Source'
  value Mic
  comment {
   access 'read write'
   type ENUMERATED
   count 1
   item.0 Mic
   item.1 Line
  }
 }
}
