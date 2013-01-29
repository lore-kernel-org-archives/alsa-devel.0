From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH 1/3] x86: KVM: Fix warnings by returning bool
Date: Tue, 29 Jan 2013 18:36:03 +0200
Message-ID: <20130129163603.GD627@redhat.com>
References: <1359304802-28240-1-git-send-email-emilgoode@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=cp1255
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359304802-28240-1-git-send-email-emilgoode@gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Emil Goode <emilgoode@gmail.com>
Cc: mtosatti@redhat.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, avi@redhat.com, mst@redhat.com, perex@perex.cz, tiwai@suse.de, crimsun@ubuntu.com, wfp5p@virginia.edu, peter.senna@gmail.com, x86@kernel.org, kvm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 27, 2013 at 05:40:00PM +0100, Emil Goode wrote:
> The function pointer x2apic_available in struct hypervisor_x86 is
> supposed to point to functions that return bool. This patch changes
> the return type of the kvm_para_available function to bool.
>=20
> Sparse warnings:
>=20
> arch/x86/kernel/kvm.c:508:35: warning:
> 	incorrect type in initializer (different signedness)
> 	arch/x86/kernel/kvm.c:508:35:
> 	expected bool ( *x2apic_available )( ... )
> 	arch/x86/kernel/kvm.c:508:35:
> 	got int ( static inline [toplevel] *<noident> )( ... )
>=20
> arch/x86/kernel/kvm.c:508:2: warning:
> 	initialization from incompatible pointer type [enabled by default]
>=20
> arch/x86/kernel/kvm.c:508:2: warning:
> 	(near initialization for =91x86_hyper_kvm.x2apic_available=92)
> 	[enabled by default]
>=20
The breakage was in tip x86/apic tree only and it was fixed by
3b4a505821 there.

> Signed-off-by: Emil Goode <emilgoode@gmail.com>
> ---
>  arch/x86/include/asm/kvm_para.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/k=
vm_para.h
> index 0be7039..695399f 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -85,13 +85,13 @@ static inline long kvm_hypercall4(unsigned int nr=
, unsigned long p1,
>  	return ret;
>  }
> =20
> -static inline int kvm_para_available(void)
> +static inline bool kvm_para_available(void)
>  {
>  	unsigned int eax, ebx, ecx, edx;
>  	char signature[13];
> =20
>  	if (boot_cpu_data.cpuid_level < 0)
> -		return 0;	/* So we don't blow up on old processors */
> +		return false;	/* So we don't blow up on old processors */
> =20
>  	if (cpu_has_hypervisor) {
>  		cpuid(KVM_CPUID_SIGNATURE, &eax, &ebx, &ecx, &edx);
> @@ -101,10 +101,10 @@ static inline int kvm_para_available(void)
>  		signature[12] =3D 0;
> =20
>  		if (strcmp(signature, "KVMKVMKVM") =3D=3D 0)
> -			return 1;
> +			return true;
>  	}
> =20
> -	return 0;
> +	return false;
>  }
> =20
>  static inline unsigned int kvm_arch_para_features(void)
> --=20
> 1.7.10.4

--
			Gleb.
