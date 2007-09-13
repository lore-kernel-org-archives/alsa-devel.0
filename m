From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ALSA changes in 2.6.23-rc6 for Intel HDA
Date: Thu, 13 Sep 2007 13:15:00 -0400
Message-ID: <9e4733910709131015y7c1d4238ue4ee97ef5bff1e29@mail.gmail.com>
References: <9e4733910709110958h5756a50fi7540fe9d654d1557@mail.gmail.com>
	<200709121600.42015.maximlevitsky@gmail.com>
	<9e4733910709120730y34275a5t89c38a20938d0e7e@mail.gmail.com>
	<200709131916.47518.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by alsa0.perex.cz (Postfix) with ESMTP id BE478243AA
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 19:15:02 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so431489nzf
	for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2007 10:15:01 -0700 (PDT)
In-Reply-To: <200709131916.47518.maximlevitsky@gmail.com>
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
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/13/07, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> It mustn't be the kernel
> Last change in hda-intel code in in pre-2.6.23-rc1
>
> by the way, PCM control is not hardware control
> it is a softvol plug-in

I wasn't paying a lot of attention when the changed happen. I upgraded
the kernel and when it booted all of my sound was missing. I played
around with it until I determined that the sound was still there but
at very low volumes.

I'm running Ubuntu 7.04 64b. Nothing special, using the default audio
install. I am compiling and installing my own kernels.

Are these entries with all the zeros normal?
/var/lib/alsa/asound.state

state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		iface MIXER
		name 'InMux Capture Volume'
		value.0 0
		value.1 0
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 14'
		iface MIXER
		name 'InVol Capture Volume'
		value.0 0
		value.1 0
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'ADCMux Capture Switch'
		value.0 false
		value.1 false
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		iface MIXER
		name 'Front Playback Volume'
		value.0 75
		value.1 75
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		iface MIXER
		name 'Surround Playback Volume'
		value.0 100
		value.1 100
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 false
		value.1 false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 127'
		iface MIXER
		name 'Center Playback Volume'
		value 100
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value false
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 127'
		iface MIXER
		name 'LFE Playback Volume'
		value 100
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value false
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		iface MIXER
		name 'Side Playback Volume'
		value.0 100
		value.1 100
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Side Playback Switch'
		value.0 false
		value.1 false
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 180
		value.1 180
	}
}



-- 
Jon Smirl
jonsmirl@gmail.com
