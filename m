From: jack craig <jackc@linuxlighthouse.com>
Subject: Skype beta better audio, but crashing after launch...
Date: Fri, 28 Aug 2009 09:51:17 -0700
Message-ID: <4A980B05.2010405@linuxlighthouse.com>
Reply-To: "Community assistance, encouragement,
	and advice for using Fedora." <fedora-list@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <fedora-list-bounces@redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/fedora-list>,
	<mailto:fedora-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/fedora-list>
List-Post: <mailto:fedora-list@redhat.com>
List-Help: <mailto:fedora-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/fedora-list>,
	<mailto:fedora-list-request@redhat.com?subject=subscribe>
Sender: fedora-list-bounces@redhat.com
Errors-To: fedora-list-bounces@redhat.com
To: "Community assistance, encouragement,
	and advice for using Fedora." <fedora-list@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I thought i'd start a new thread given the progress the beta provides.
now my test sound makes a noise and my test call lanuches and stops when 
i tell it to, BUT!

it crashes with the below.

pulseaudio[3400]: resampler.c: Using float32le as working format.
pulseaudio[3400]: resampler.c: Choosing speex quality setting 3.
pulseaudio[3400]: source-output.c: Created output 0 "Input" on 
alsa_input.pci_8086_24c5_sound_card_0 with sample spec s16le 1ch 16000Hz 
and channel map mono
pulseaudio[3400]: protocol-native.c: Final latency 199.89 ms = 99.94 ms 
+ 99.95 ms
  pulseaudio[3400]: source.c: Assertion 'pa_cvolume_compatible(volume, 
&s->sample_spec)' failed at pulsecore/source.c:666, function 
pa_source_set_volume(). Aborting.

any suggestions on fixing this ?

tia, jackc...

-- 
    jack craig
       jackc@LinuxLightHouse.com
          831-684-1375 (Office)
             831-596-6924 (cell)
                IM: jackcraigaptos (AIM)

_________________________________
This email has been ClamScanned !
     www.LinuxLightHouse.com

-- 
fedora-list mailing list
fedora-list@redhat.com
To unsubscribe: https://www.redhat.com/mailman/listinfo/fedora-list
Guidelines: http://fedoraproject.org/wiki/Communicate/MailingListGuidelines
